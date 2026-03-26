<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>

    <style>
      body {
        font-family: "Segoe UI", sans-serif;
        background: linear-gradient(135deg, #0a1f44, #000000);
      }

      .hero-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 60px 20px;
      }

      .main-card {
        background: rgba(255, 255, 255, 0.96);
        border-radius: 16px;
        padding: 50px;
        max-width: 1200px;
        width: 100%;
        box-shadow: 0 25px 70px rgba(0, 0, 0, 0.5);
        transition: 0.4s;
      }

      .main-card:hover {
        transform: translateY(-6px);
      }

      .title {
        font-size: 3rem;
        font-weight: bold;
        color: #0a1f44;
      }

      .subtitle {
        color: #555;
        margin-bottom: 40px;
      }

      .section {
        margin-top: 60px;
        text-align: left;
      }

      .section h3 {
        color: #0a1f44;
        margin-bottom: 20px;
        font-weight: 600;
      }

      .feature-card,
      .step-card,
      .stat-card {
        background: #f8f9fc;
        border-radius: 12px;
        padding: 25px;
        transition: 0.3s;
        height: 100%;
      }

      .feature-card:hover,
      .step-card:hover,
      .stat-card:hover {
        transform: scale(1.05);
        background: #eef2ff;
      }

      .btn-custom {
        padding: 12px 30px;
        border-radius: 30px;
        font-weight: 600;
        transition: 0.3s;
        margin: 10px;
      }

      .btn-login {
        background: #0a1f44;
        color: white;
      }

      .btn-login:hover {
        background: black;
      }

      .btn-signup {
        border: 2px solid #0a1f44;
        color: #0a1f44;
      }

      .btn-signup:hover {
        background: #0a1f44;
        color: white;
      }

      p {
        color: #444;
        line-height: 1.7;
      }
    </style>
  </head>

  <body>
    <%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

    <div class="hero-section">
      <div class="main-card text-center">
        <!-- HERO -->
        <h1 class="title">Votify</h1>
        <p class="subtitle">
          A secure, transparent and modern digital voting platform
        </p>

        <!-- FEATURES -->
        <div class="row g-4">
          <div class="col-md-4">
            <div class="feature-card">
              <h5>🔐 Security</h5>
              <p>
                Advanced encryption ensures every vote is protected and
                tamper-proof.
              </p>
            </div>
          </div>

          <div class="col-md-4">
            <div class="feature-card">
              <h5>⚡ Speed</h5>
              <p>Instant vote processing with real-time results.</p>
            </div>
          </div>

          <div class="col-md-4">
            <div class="feature-card">
              <h5>🌍 Accessibility</h5>
              <p>Vote anytime, anywhere with ease and convenience.</p>
            </div>
          </div>
        </div>

        <!-- HOW IT WORKS -->
        <div class="section">
          <h3>How It Works</h3>
          <div class="row g-4">
            <div class="col-md-3">
              <div class="step-card">
                <h6>1. Register</h6>
                <p>Create an account with your basic details securely.</p>
              </div>
            </div>

            <div class="col-md-3">
              <div class="step-card">
                <h6>2. Verify</h6>
                <p>Confirm your identity through email verification.</p>
              </div>
            </div>

            <div class="col-md-3">
              <div class="step-card">
                <h6>3. Vote</h6>
                <p>Select candidates and cast your vote easily.</p>
              </div>
            </div>

            <div class="col-md-3">
              <div class="step-card">
                <h6>4. Results</h6>
                <p>View real-time election results instantly.</p>
              </div>
            </div>
          </div>
        </div>

        <!-- WHY CHOOSE US -->
        <div class="section">
          <h3>Why Choose Votify?</h3>
          <p>
            Votify is designed to eliminate the challenges of traditional voting
            systems. It provides a secure and transparent platform that ensures
            fairness, accessibility, and efficiency in every election process.
          </p>

          <p>
            With strong authentication systems, encrypted data transmission, and
            real-time monitoring, users can confidently participate in elections
            while administrators maintain complete control and oversight.
          </p>
        </div>

        <!-- STATS -->
        <div class="section">
          <h3>Our Impact</h3>
          <div class="row g-4 text-center">
            <div class="col-md-4">
              <div class="stat-card">
                <h4>10,000+</h4>
                <p>Votes Cast</p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="stat-card">
                <h4>500+</h4>
                <p>Elections Conducted</p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="stat-card">
                <h4>99.9%</h4>
                <p>System Reliability</p>
              </div>
            </div>
          </div>
        </div>

        <!-- ABOUT -->
        <div class="section">
          <h3>About the Platform</h3>
          <p>
            Votify is a next-generation digital voting system built to enhance
            democratic participation. It simplifies the voting process while
            maintaining high standards of security and transparency.
          </p>

          <p>
            The system supports multiple election formats and ensures that every
            vote is recorded accurately. Its user-friendly interface allows
            users of all backgrounds to participate without difficulty.
          </p>
        </div>

        <!-- CTA -->
        <div class="section text-center">
          <h3>Get Started</h3>
          <p>Join the future of digital voting today.</p>

          <a
            href="<%=request.getContextPath()%>/login"
            class="btn btn-custom btn-login"
          >
            Login
          </a>

          <a
            href="<%=request.getContextPath()%>/register"
            class="btn btn-custom btn-signup"
          >
            Create Account
          </a>
        </div>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
  </body>
</html>
