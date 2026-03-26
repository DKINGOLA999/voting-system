package com.bascode.services;

import com.bascode.model.entity.Contester;
import com.bascode.model.entity.Election;
import com.bascode.model.entity.User;
import com.bascode.model.entity.Vote;
import com.bascode.model.enums.ContesterStatus;
import com.bascode.model.enums.Position;
import com.bascode.model.enums.Role;
import com.bascode.util.EmailService;
import com.bascode.util.PasswordUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.UUID;

public class UserServiceImpl implements UserService {

    private final EntityManager em;

    // Constructor receives EntityManager from Servlet
    public UserServiceImpl(EntityManager em) {
        this.em = em;
    }

    // 1. REGISTER USER (VOTER OR CONTESTER)
    @Override
    public boolean registerUser(User user) {
        try {
            em.getTransaction().begin();

            // Check if email already exists
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.email = :email",
                    Long.class
            );
            query.setParameter("email", user.getEmail());

            Long count = query.getSingleResult();
            if (count > 0) {
                em.getTransaction().rollback();
                return false; // Email already exists
            }

            // Hash password before saving
            String hashed = PasswordUtil.hashPassword(user.getPasswordHash());
            user.setPasswordHash(hashed);

            // Generate 6-character verification code
            String code = UUID.randomUUID().toString().substring(0, 6);
            user.setVerificationCode(code);

            // Default: not verified
            user.setEmailVerified(false);

            em.persist(user);
            em.getTransaction().commit();

            return true;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    // 2. LOGIN USER
    @Override
    public User login(String email, String password) {
        try {
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );
            query.setParameter("email", email);

            User user = query.getSingleResult();

            // Check if verified
            if (!user.isEmailVerified()) {
                return null;
            }

            // Check password
            if (PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 3. VERIFY EMAIL
    @Override
    public boolean verifyEmail(String email, String code) {
        try {
            em.getTransaction().begin();

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );
            query.setParameter("email", email);

            User user = query.getSingleResult();

            if (user.getVerificationCode().equals(code)) {
                user.setEmailVerified(true);
                user.setVerificationCode(null);
                em.merge(user);
                em.getTransaction().commit();
                return true;
            }

            em.getTransaction().rollback();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }

        return false;
    }

    // 4. RESEND OTP
    @Override
    public boolean resendOtp(String email) {
        try {
            em.getTransaction().begin();

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );
            query.setParameter("email", email);

            User user = query.getSingleResult();

            // Generate new 6-character verification code
            String code = UUID.randomUUID().toString().substring(0, 6);
            user.setVerificationCode(code);

            em.merge(user);
            em.getTransaction().commit();

            // Send email with new code
            EmailService.sendResendOtpEmail(user.getEmail(), code);

            return true;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    // 5. INITIATE PASSWORD RESET
    @Override
    public boolean initiatePasswordReset(String email) {
        try {
            em.getTransaction().begin();

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );
            query.setParameter("email", email);

            User user = query.getSingleResult();

            // Generate reset code
            String code = UUID.randomUUID().toString().substring(0, 6);
            user.setVerificationCode(code);

            em.merge(user);
            em.getTransaction().commit();

            // Send email with reset code
            EmailService.sendPasswordResetEmail(user.getEmail(), code);

            return true;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    // 6. RESET PASSWORD
    @Override
    public boolean resetPassword(String email, String code, String newPassword) {
        try {
            em.getTransaction().begin();

            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email",
                    User.class
            );
            query.setParameter("email", email);

            User user = query.getSingleResult();

            if (user.getVerificationCode().equals(code)) {
                // Hash new password
                String hashed = PasswordUtil.hashPassword(newPassword);
                user.setPasswordHash(hashed);
                user.setVerificationCode(null);

                em.merge(user);
                em.getTransaction().commit();
                return true;
            }

            em.getTransaction().rollback();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }

        return false;
    }

    // === New voting / contest feature methods ===

    @Override
    public boolean registerContester(User user, Position position, String manifesto) {
        try {
            TypedQuery<Long> existingQuery = em.createQuery(
                    "SELECT COUNT(c) FROM Contester c WHERE c.user = :user", Long.class);
            existingQuery.setParameter("user", user);
            if (existingQuery.getSingleResult() > 0) {
                return false;
            }

            TypedQuery<Long> countQuery = em.createQuery(
                    "SELECT COUNT(c) FROM Contester c WHERE c.position = :position AND c.status = :status", Long.class);
            countQuery.setParameter("position", position);
            countQuery.setParameter("status", ContesterStatus.APPROVED);

            if (countQuery.getSingleResult() >= 3) {
                return false;
            }

            em.getTransaction().begin();
            Contester contester = new Contester();
            contester.setUser(user);
            contester.setPosition(position);
            contester.setStatus(ContesterStatus.PENDING);
            contester.setManifesto(manifesto);
            em.persist(contester);
            em.getTransaction().commit();
            return true;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean withdrawContester(User user) {
        try {
            TypedQuery<Contester> query = em.createQuery(
                    "SELECT c FROM Contester c WHERE c.user = :user", Contester.class);
            query.setParameter("user", user);
            Contester contester = query.getSingleResult();

            if (contester == null) {
                return false;
            }

            em.getTransaction().begin();
            contester.setStatus(ContesterStatus.DENIED);
            contester.getUser().setRole(Role.VOTER);
            em.merge(contester.getUser());
            em.merge(contester);
            em.getTransaction().commit();
            return true;

        } catch (jakarta.persistence.NoResultException nre) {
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean hasUserVoted(User voter) {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Vote v WHERE v.voter = :voter", Long.class);
        query.setParameter("voter", voter);
        return query.getSingleResult() > 0;
    }

    @Override
    public boolean isUserContester(User user) {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM Contester c WHERE c.user = :user AND c.status = :status", Long.class);
        query.setParameter("user", user);
        query.setParameter("status", ContesterStatus.APPROVED);
        return query.getSingleResult() > 0;
    }

    @Override
    public ContesterStatus getContesterStatus(User user) {
        TypedQuery<Contester> query = em.createQuery(
                "SELECT c FROM Contester c WHERE c.user = :user", Contester.class);
        query.setParameter("user", user);
        List<Contester> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0).getStatus();
    }

    @Override
    public java.util.List<Contester> getApprovedContesters() {
        TypedQuery<Contester> query = em.createQuery(
                "SELECT c FROM Contester c WHERE c.status = :status", Contester.class);
        query.setParameter("status", ContesterStatus.APPROVED);
        return query.getResultList();
    }

    @Override
    public long countVotesForContester(Contester contester) {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Vote v WHERE v.contester = :contester", Long.class);
        query.setParameter("contester", contester);
        return query.getSingleResult();
    }

    @Override
    public boolean voteForContester(User voter, Long contesterId) {
        if (hasUserVoted(voter)) {
            return false;
        }

        Contester target = em.find(Contester.class, contesterId);
        if (target == null || target.getStatus() != ContesterStatus.APPROVED) {
            return false;
        }

        if (voter.getRole() == Role.CONTESTER && !target.getUser().getId().equals(voter.getId())) {
            // contesters can only vote for themselves
            return false;
        }

        try {
            em.getTransaction().begin();
            Vote vote = new Vote();
            vote.setVoter(voter);
            vote.setContester(target);
            em.persist(vote);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateProfile(User user, String firstName, String lastName, String newPassword) {
        try {
            em.getTransaction().begin();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                user.setPasswordHash(PasswordUtil.hashPassword(newPassword));
            }
            em.merge(user);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean changePassword(User user, String currentPassword, String newPassword) {
        try {
            em.getTransaction().begin();
            // Verify current password
            if (!PasswordUtil.checkPassword(currentPassword, user.getPasswordHash())) {
                em.getTransaction().rollback();
                return false;
            }
            // Update to new password
            user.setPasswordHash(PasswordUtil.hashPassword(newPassword));
            em.merge(user);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    // GET ALL USERS (Admin Panel)
    @Override
    public List<User> getAllUsers() {
        TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u",
                User.class
        );
        return query.getResultList();
    }

    // ELECTION MANAGEMENT
    @Override
    public Election getCurrentElection() {
        TypedQuery<Election> query = em.createQuery(
                "SELECT e FROM Election e WHERE e.active = true", Election.class);
        List<Election> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public boolean setElectionDates(java.time.LocalDateTime start, java.time.LocalDateTime end) {
        try {
            em.getTransaction().begin();
            Election election = getCurrentElection();
            if (election == null) {
                election = new Election();
                election.setActive(true);
                em.persist(election);
            }
            election.setStartDate(start);
            election.setEndDate(end);
            em.merge(election);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean startElection() {
        try {
            em.getTransaction().begin();
            Election election = getCurrentElection();
            if (election != null) {
                election.setStartDate(java.time.LocalDateTime.now());
                em.merge(election);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean endElection() {
        try {
            em.getTransaction().begin();
            Election election = getCurrentElection();
            if (election != null) {
                election.setEndDate(java.time.LocalDateTime.now());
                em.merge(election);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public java.util.Map<Position, java.util.List<Contester>> getElectionResults() {
        java.util.Map<Position, java.util.List<Contester>> results = new java.util.HashMap<>();
        for (Position pos : Position.values()) {
            TypedQuery<Contester> query = em.createQuery(
                    "SELECT c FROM Contester c WHERE c.position = :position AND c.status = :status ORDER BY (SELECT COUNT(v) FROM Vote v WHERE v.contester = c) DESC", Contester.class);
            query.setParameter("position", pos);
            query.setParameter("status", ContesterStatus.APPROVED);
            results.put(pos, query.getResultList());
        }
        return results;
    }
}
