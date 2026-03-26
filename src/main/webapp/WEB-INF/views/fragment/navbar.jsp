<nav class="navbar navbar-expand-lg fixed-top glass">
  <div class="container">
    <!-- LOGO -->
    <a
      class="navbar-brand text-white fw-bold fs-4"
      href="<%=request.getContextPath()%>/"
    >
      Votify
    </a>

    <!-- MOBILE TOGGLE -->
    <button
      class="navbar-toggler text-white"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#nav"
    >
      ☰
    </button>

    <div class="collapse navbar-collapse" id="nav">
      <!-- LINKS -->
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/" class="nav-link text-white"
            >Home</a
          >
        </li>

        <li class="nav-item">
          <a
            href="<%=request.getContextPath()%>/about.jsp"
            class="nav-link text-white"
            >About</a
          >
        </li>

        <li class="nav-item">
          <a
            href="<%=request.getContextPath()%>/services.jsp"
            class="nav-link text-white"
            >Services</a
          >
        </li>

        <li class="nav-item">
          <a
            href="<%=request.getContextPath()%>/contacts.jsp"
            class="nav-link text-white"
            >Contact</a
          >
        </li>

        <!-- AUTH BUTTONS -->
        <li class="nav-item ms-3">
          <a
            href="<%=request.getContextPath()%>/login"
            class="btn btn-outline-light btn-sm"
          >
            Login
          </a>
        </li>

        <li class="nav-item ms-2">
          <a
            href="<%=request.getContextPath()%>/register"
            class="btn btn-primary btn-sm"
          >
            Sign Up
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script>
  window.addEventListener("scroll", function () {
    const nav = document.querySelector(".navbar");
    nav.classList.toggle("navbar-scrolled", window.scrollY > 50);
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
