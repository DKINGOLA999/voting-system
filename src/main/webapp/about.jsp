<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="/WEB-INF/views/fragment/head.jsp" %>
    <title>About - Votify</title>
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
        padding: 80px 0;
      }
      .bg-overlay::before {
        content: "";
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.7);
      }
      .content {
        position: relative;
        z-index: 2;
      }
      .card-hover {
        background: rgba(0, 0, 0, 0.6);
        padding: 25px;
        border-radius: 15px;
        transition: 0.4s;
      }
      .card-hover:hover {
        transform: scale(1.05);
      }
      .img-small {
        width: 100px;
        height: 100px;
        border-radius: 10px;
        object-fit: cover;
        margin: 5px;
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
        <h1 class="mb-4">About Votify</h1>
        <p class="lead mb-5">
          We are passionate about bringing transparency and security to digital
          voting for everyone.
        </p>

        <div class="row g-4">
          <div class="col-md-4">
            <div class="card-hover">
              <h4>Our Mission</h4>
              <p>Ensure secure, fair, and transparent elections.</p>
              <img
                class="img-small"
                src="https://images.unsplash.com/photo-1602906530215-1bf5f4925279?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8dm90ZXxlbnwwfHwwfHx8MA%3D%3D"
              />
            </div>
          </div>

          <div class="col-md-4">
            <div class="card-hover">
              <h4>Our Vision</h4>
              <p>Every citizen can vote securely from anywhere.</p>
              <img
                class="img-small"
                src="https://plus.unsplash.com/premium_photo-1663126272118-1df214328644?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dm90ZXxlbnwwfHwwfHx8MA%3D%3D"
              />
            </div>
          </div>

          <div class="col-md-4">
            <div class="card-hover">
              <h4>Our Technology</h4>
              <p>
                Advanced authentication, encrypted systems, and validated voting
                processes.
              </p>
              <img
                class="img-small"
                src="https://plus.unsplash.com/premium_photo-1708598525588-eae2b2d05a9e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dm90ZXxlbnwwfHwwfHx8MA%3D%3D"
              />
            </div>
          </div>
        </div>

        <div class="mt-5">
          <h2>Our Story</h2>
          <p>
            Votify was born from a simple yet powerful idea: that every voice
            should be heard, and every vote should count. Founded in 2020 by a
            team of cybersecurity experts, software engineers, and election
            integrity advocates, Votify emerged during a time when traditional
            voting systems were being challenged by new technologies and
            changing societal needs.
          </p>

          <p>
            Our founders recognized that while digital transformation was
            revolutionizing every aspect of modern life, voting systems had
            largely remained stuck in the 20th century. Paper ballots,
            mechanical machines, and manual counting processes were prone to
            errors, delays, and security vulnerabilities. We set out to create a
            voting platform that would leverage the best of modern technology
            while maintaining the trust and integrity that elections require.
          </p>

          <p>
            From the beginning, we focused on three core principles: security,
            accessibility, and transparency. We assembled a world-class team of
            experts in cryptography, distributed systems, user experience
            design, and election law. Our diverse team brings together
            perspectives from academia, government, and the private sector,
            ensuring that Votify meets the highest standards of security and
            usability.
          </p>

          <p>
            Our journey began with extensive research and development. We
            studied voting systems from around the world, analyzed security
            threats, and consulted with election officials, voters, and
            cybersecurity experts. This comprehensive approach allowed us to
            design a system that addresses real-world challenges while
            anticipating future needs.
          </p>

          <p>
            Today, Votify is trusted by governments, organizations, and
            communities worldwide. Our platform has been used in elections
            ranging from local school board races to national referendums. Each
            implementation has taught us valuable lessons, which we incorporate
            into continuous improvements to our system.
          </p>

          <p>
            We believe that technology should serve democracy, not define it.
            That's why we work closely with election authorities, civil society
            organizations, and international bodies to ensure that our platform
            aligns with democratic principles and legal requirements.
          </p>

          <p>
            Our commitment to open source development means that our core
            technologies are available for independent review and verification.
            This transparency builds trust and allows the global community to
            contribute to the improvement of our system.
          </p>

          <p>
            As we look to the future, we're excited about the possibilities that
            emerging technologies bring to voting. From AI-powered accessibility
            features to decentralized identity systems, we're continuously
            innovating to make voting even more secure, convenient, and
            inclusive.
          </p>

          <p>
            But our mission remains the same: to empower every citizen to
            participate in the democratic process with confidence. We believe
            that when people trust their voting systems, they trust their
            democracy. That's the Votify promise.
          </p>

          <p>
            Join us in building a more participatory and trustworthy democracy.
            Whether you're an election official, a voter, or a technology
            enthusiast, we invite you to learn more about how Votify is shaping
            the future of elections.
          </p>

          <p>
            Our team is dedicated to excellence in everything we do. From our
            rigorous testing protocols to our responsive customer support, we
            strive to exceed expectations at every turn. We're not just building
            a voting platform; we're building trust in democracy itself.
          </p>

          <p>
            Thank you for considering Votify. Together, we can create elections
            that are not only secure and efficient but also truly representative
            of the will of the people.
          </p>
        </div>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/fragment/footer.jsp" %>
  </body>
</html>
