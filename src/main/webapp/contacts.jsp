<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/fragment/head.jsp" %>
<title>Contact - Votify</title>

<style>
body{
    font-family:'Segoe UI',sans-serif;
    background: linear-gradient(135deg,#0a1f44,#000000);
}

.hero-section{
    min-height:100vh;
    padding:80px 20px;
    display:flex;
    justify-content:center;
    align-items:center;
}

.main-card{
    background:rgba(255,255,255,0.96);
    border-radius:16px;
    padding:50px;
    max-width:1200px;
    width:100%;
    box-shadow:0 25px 70px rgba(0,0,0,0.5);
    transition:0.4s;
}

.main-card:hover{
    transform:translateY(-5px);
}

h1{
    color:#0a1f44;
    font-weight:700;
}

.section{
    margin-top:60px;
}

.section h3{
    color:#0a1f44;
    margin-bottom:20px;
    font-weight:600;
}

p{
    color:#444;
    line-height:1.7;
}

.form-card{
    background:#f8f9fc;
    padding:30px;
    border-radius:12px;
    transition:0.3s;
}

.form-card:hover{
    transform:scale(1.02);
}

.info-card{
    background:#f8f9fc;
    padding:20px;
    border-radius:12px;
    transition:0.3s;
    height:100%;
}

.info-card:hover{
    transform:scale(1.05);
    background:#eef2ff;
}

.form-control{
    border-radius:10px;
    padding:12px;
}

.btn-send{
    background:#0a1f44;
    color:white;
    padding:12px;
    border-radius:25px;
    transition:0.3s;
}

.btn-send:hover{
    background:black;
}
</style>
</head>

<body>

<%@ include file="/WEB-INF/views/fragment/navbar.jsp" %>

<div class="hero-section">
<div class="main-card">

    <!-- HEADER -->
    <div class="text-center">
        <h1>Contact Us</h1>
        <p style="color:#555;">
            We’re here to support you and answer any questions about Votify.
        </p>
    </div>

    <!-- CONTACT FORM -->
    <div class="section">
        <h3>Send Us a Message</h3>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="form-card">

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>

                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="contact" method="post">
                        <input type="text" name="name" class="form-control mb-3" placeholder="Full Name" required>

                        <input type="email" name="email" class="form-control mb-3" placeholder="Email Address" required>

                        <textarea name="message" class="form-control mb-3" rows="5" placeholder="Write your message..." required></textarea>

                        <button class="btn btn-send w-100">Send Message</button>
                    </form>

                </div>
            </div>

            <!-- CONTACT INFO -->
            <div class="col-md-6">
                <div class="info-card">
                    <h5>📍 Office</h5>
                    <p>Tech Innovation District, Global Hub</p>

                    <h5 class="mt-3">📧 Email</h5>
                    <p>support@votify.com</p>

                    <h5 class="mt-3">📞 Phone</h5>
                    <p>+234 000 000 0000</p>

                    <h5 class="mt-3">⏰ Availability</h5>
                    <p>24/7 Support for all users</p>
                </div>
            </div>
        </div>
    </div>

    <!-- HOW IT WORKS -->
    <div class="section">
        <h3>How We Support You</h3>
        <p>
            Votify provides a seamless support experience for all users. Once you send
            a message, our system routes your request to the appropriate team based
            on your needs. Whether it's technical assistance, general inquiries,
            or partnership opportunities, you receive timely and relevant responses.
        </p>

        <p>
            Our support team ensures quick resolution by combining automation with
            human expertise, ensuring every issue is handled efficiently and professionally.
        </p>
    </div>

    <!-- SERVICES -->
    <div class="section">
        <h3>Support Services</h3>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="info-card">
                    <h6>Technical Support</h6>
                    <p>Help with system usage, bugs, and troubleshooting.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="info-card">
                    <h6>Consultation</h6>
                    <p>Guidance for implementing Votify in your organization.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="info-card">
                    <h6>Partnership</h6>
                    <p>Collaboration opportunities with institutions and teams.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- WHY CONTACT US -->
    <div class="section">
        <h3>Why Reach Out to Us?</h3>
        <p>
            At Votify, we prioritize user satisfaction and system reliability.
            Our team is dedicated to ensuring that every interaction is meaningful,
            helpful, and solution-oriented.
        </p>

        <p>
            Whether you are a first-time user or managing a large election,
            our team is ready to guide you every step of the way.
        </p>
    </div>

    <!-- FINAL CTA -->
    <div class="section text-center">
        <h3>Stay Connected</h3>
        <p>
            Reach out today and experience professional, reliable support tailored to your needs.
        </p>
    </div>

</div>
</div>

<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

</body>
</html>