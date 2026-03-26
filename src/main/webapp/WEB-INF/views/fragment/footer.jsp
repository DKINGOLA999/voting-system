<footer class="footer-dark text-white pt-5 pb-4">
  <div class="container">
    <div class="row">
      <!-- BRAND -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">Votify</h5>
        <p class="text-soft">
          A secure, transparent and modern digital voting platform designed to
          make elections simple, reliable, and accessible for everyone.
        </p>
      </div>

      <!-- LINKS -->
      <div class="col-md-4 mb-4">
        <h6 class="fw-bold">Quick Links</h6>
        <ul class="list-unstyled">
          <li>
            <a
              href="<%=request.getContextPath()%>/"
              class="text-soft text-decoration-none"
              >Home</a
            >
          </li>
          <li>
            <a
              href="<%=request.getContextPath()%>/about.jsp"
              class="text-soft text-decoration-none"
              >About</a
            >
          </li>
          <li>
            <a
              href="<%=request.getContextPath()%>/services.jsp"
              class="text-soft text-decoration-none"
              >Services</a
            >
          </li>
          <li>
            <a
              href="<%=request.getContextPath()%>/contacts.jsp"
              class="text-soft text-decoration-none"
              >Contact</a
            >
          </li>
        </ul>
      </div>

      <!-- AUTH -->
      <div class="col-md-4 mb-4">
        <h6 class="fw-bold">Account</h6>
        <ul class="list-unstyled">
          <li>
            <a
              href="<%=request.getContextPath()%>/login"
              class="text-soft text-decoration-none"
              >Login</a
            >
          </li>
          <li>
            <a
              href="<%=request.getContextPath()%>/register"
              class="text-soft text-decoration-none"
              >Sign Up</a
            >
          </li>
        </ul>
      </div>
    </div>

    <!-- BOTTOM -->
    <div class="text-center mt-4 border-top pt-3 text-soft">
      &copy; 2026 Votify. All rights reserved.
    </div>
  </div>
</footer>
