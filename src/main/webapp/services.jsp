<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>

    <title>Services - Votify</title>

    <style>
      body {
        font-family: "Segoe UI", sans-serif;
        background: linear-gradient(135deg, #0a1f44, #000000);
      }

      .hero-section {
        min-height: 100vh;
        padding: 80px 20px;
        display: flex;
        justify-content: center;
        align-items: center;
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
        transform: translateY(-5px);
      }

      h1 {
        color: #0a1f44;
        font-weight: 700;
      }

      .section {
        margin-top: 60px;
      }

      .section h3 {
        color: #0a1f44;
        margin-bottom: 20px;
        font-weight: 600;
      }

      p {
        color: #444;
        line-height: 1.7;
      }

      .service-card {
        background: #f8f9fc;
        padding: 25px;
        border-radius: 12px;
        transition: 0.3s;
        height: 100%;
      }

      .service-card:hover {
        transform: scale(1.05);
        background: #eef2ff;
      }

      .feature-box {
        background: #f8f9fc;
        padding: 20px;
        border-radius: 12px;
        transition: 0.3s;
      }

      .feature-box:hover {
        transform: scale(1.05);
      }
    </style>
  </head>

  <body>
    <%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

    <div class="hero-section">
      <div class="main-card">
        <!-- HEADER -->
        <div class="text-center">
          <h1>Our Services</h1>
          <p style="color: #555">
            Comprehensive digital solutions designed to deliver secure,
            efficient, and transparent elections.
          </p>
        </div>

        <!-- CORE SERVICES -->
        <div class="section">
          <h3>Core Services</h3>

          <div class="row g-4">
            <div class="col-md-4">
              <div class="service-card">
                <h5>🔐 Secure Voting</h5>
                <p>
                  End-to-end encrypted voting system ensuring privacy and
                  integrity.
                </p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="service-card">
                <h5>⚡ Real-Time Results</h5>
                <p>
                  Instant vote processing with accurate and transparent results.
                </p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="service-card">
                <h5>🛡️ Fraud Detection</h5>
                <p>
                  AI-powered monitoring to detect and prevent suspicious
                  activities.
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- HOW IT WORKS -->
        <div class="section">
          <h3>How It Works</h3>
          <p>
            Votify provides a seamless election workflow from start to finish.
            Administrators set up elections, register voters, and configure
            ballots. Voters then securely access the system, verify their
            identity, and cast their votes with ease.
          </p>

          <p>
            Behind the scenes, advanced systems ensure encryption, monitoring,
            and real-time processing, delivering accurate results while
            maintaining full transparency.
          </p>
        </div>

        <!-- EXTENDED FEATURES -->
        <div class="section">
          <h3>Advanced Features</h3>

          <div class="row g-4">
            <div class="col-md-4">
              <div class="feature-box">
                <h6>Voter Management</h6>
                <p>
                  Efficient registration, validation, and database handling.
                </p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="feature-box">
                <h6>Ballot Customization</h6>
                <p>
                  Support for complex elections and multiple voting formats.
                </p>
              </div>
            </div>

            <div class="col-md-4">
              <div class="feature-box">
                <h6>Multi-Device Access</h6>
                <p>
                  Fully responsive across mobile, tablet, and desktop devices.
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- WHY OUR SERVICES -->
        <div class="section">
          <h3>Why Our Services Stand Out</h3>
          <p>
            Votify combines simplicity with advanced technology, ensuring that
            elections are not only secure but also easy to manage and
            participate in.
          </p>

          <p>
            Our platform is scalable, reliable, and designed to adapt to
            different organizational needs, from small groups to large-scale
            national elections.
          </p>
        </div>

        <!-- FULL SOLUTION -->
        <div class="section">
          <h3>Complete Election Solution</h3>
          <p>
            Beyond voting, Votify provides a full ecosystem that includes
            analytics, reporting, system integration, and continuous support.
            Organizations can manage every aspect of their election process
            within one platform.
          </p>

          <p>
            From planning and execution to post-election insights, our services
            ensure efficiency, transparency, and trust at every stage.
          </p>
        </div>

        <!-- FINAL CTA -->
        <div class="section text-center">
          <h3>Get Started with Votify</h3>
          <p>
            Experience a smarter, safer, and more efficient way to conduct
            elections.
          </p>
        </div>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
  </body>
</html>
