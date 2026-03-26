<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>
    <title>Home - Votify</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        margin: 0;
        color: white;
        font-family: Arial, sans-serif;
      }
      .bg-overlay {
        position: relative;
        min-height: 100vh;
        background-colour: blue;
        background-size: cover;
        padding: 80px 0;
      }
      .bg-overlay::before {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.6);
      }
      .content {
        position: relative;
        z-index: 2;
      }
      .card-dark {
        background: rgba(0, 0, 0, 0.6);
        padding: 20px;
        border-radius: 15px;
        transition: 0.3s;
      }
      .card-dark:hover {
        transform: scale(1.05);
      }
      h1,
      h2,
      p {
        text-shadow: 0 2px 5px rgba(0, 0, 0, 0.8);
      }
    </style>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

    <div class="bg-overlay">
      <div class="container content text-center">
        <h1 class="mb-4">Welcome to Votify</h1>
        <p class="lead">Secure • Transparent • Reliable Voting Platform</p>

        <div class="row mt-5 g-4">
          <div class="col-md-4">
            <div class="card-dark">Secure Authentication</div>
          </div>
          <div class="col-md-4">
            <div class="card-dark">Real-Time Results</div>
          </div>
          <div class="col-md-4">
            <div class="card-dark">Fraud Prevention</div>
          </div>
        </div>

        <div class="mt-5">
          <h2>Why Choose Votify?</h2>
          <p>
            Votify represents the next generation of electoral technology,
            combining state-of-the-art security measures with an intuitive user
            experience. Our platform is designed to make voting accessible to
            everyone, regardless of location, physical ability, or technical
            expertise.
          </p>

          <p>
            At the heart of Votify is our commitment to security. We employ
            military-grade encryption to protect voter data and ensure the
            integrity of every ballot. Our system uses a combination of
            cryptographic techniques, including homomorphic encryption for vote
            tallying and zero-knowledge proofs for verification.
          </p>

          <p>
            Transparency is not just a feature; it's the foundation of our
            platform. Every vote is recorded on an immutable blockchain ledger,
            allowing for independent audits and verification. This ensures that
            election results are not only accurate but also verifiable by any
            interested party.
          </p>

          <p>
            Our user-centric design makes voting simple and straightforward. The
            interface is clean, intuitive, and supports multiple languages.
            Voters can review their choices, make changes if needed, and submit
            their ballot with confidence. The process is designed to be as
            simple as online shopping, but with the gravity and importance of
            democracy.
          </p>

          <p>
            Votify supports a wide range of election types and ballot formats.
            From simple yes/no referendums to complex multi-candidate races with
            ranked-choice voting, our platform can handle it all. We also
            provide tools for election administrators to set up and manage
            elections efficiently.
          </p>

          <p>
            Real-time analytics and reporting give election officials
            unprecedented insight into the voting process. They can monitor
            turnout, track progress, and identify potential issues before they
            become problems. This proactive approach ensures smooth operations
            and builds confidence in the electoral process.
          </p>

          <p>
            Accessibility is a core principle of Votify. Our platform complies
            with WCAG 2.1 guidelines and supports assistive technologies. Voters
            with disabilities can use screen readers, keyboard navigation, and
            other accessibility tools to participate fully in the democratic
            process.
          </p>

          <p>
            We understand the importance of voter education. Votify includes
            built-in tools to help voters understand the issues, candidates, and
            ballot measures. This includes informational resources, sample
            ballots, and interactive guides that make informed voting easier.
          </p>

          <p>
            Our mobile-first design ensures that voters can participate from any
            device. Whether using a smartphone, tablet, or desktop computer, the
            experience is consistent and optimized. This is particularly
            important in today's mobile-centric world.
          </p>

          <p>
            Data privacy is paramount. We collect only the minimum data
            necessary to conduct elections and verify voter eligibility. All
            personal information is encrypted and stored securely, with strict
            access controls and audit logging.
          </p>

          <p>
            Votify is scalable to handle elections of any size, from small
            community polls to national elections with millions of voters. Our
            cloud-based infrastructure can scale dynamically to meet demand,
            ensuring reliable performance even during peak voting periods.
          </p>

          <p>
            We partner with cybersecurity experts and academic institutions to
            continuously improve our security measures. Regular penetration
            testing, code reviews, and security audits ensure that Votify
            remains at the forefront of election security.
          </p>

          <p>
            Our customer support team is available 24/7 to assist voters and
            election officials. We provide comprehensive documentation, training
            materials, and responsive support to ensure successful elections.
          </p>

          <p>
            Votify is more than just a voting platform; it's a tool for
            strengthening democracy. By making voting easier, more secure, and
            more transparent, we help increase voter participation and trust in
            electoral processes.
          </p>

          <p>
            Join the thousands of organizations and governments that have chosen
            Votify for their elections. Experience the difference that modern
            technology can make in the age-old practice of democracy.
          </p>

          <p>
            Our commitment to innovation means we're always evolving. Future
            updates will include advanced features like AI-powered voter
            assistance, decentralized identity integration, and enhanced
            analytics for election insights.
          </p>

          <p>
            Choose Votify for your next election. Let's work together to create
            a more inclusive, secure, and transparent democratic process.
            Contact our team today to learn how Votify can transform your
            elections.
          </p>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
  </body>
</html>
