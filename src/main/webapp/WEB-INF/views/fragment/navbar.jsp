<<<<<<< HEAD
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
=======
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

<div class="container">

<a class="navbar-brand"
href="<%=request.getContextPath()%>/">
Voting System
</a>

<button class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#navbarNav">

<span class="navbar-toggler-icon"></span>

</button>

<div class="collapse navbar-collapse"
id="navbarNav">

<ul class="navbar-nav ms-auto">

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/">
Home
</a>
</li>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/about">
About
</a>
</li>

<%
Object user = session.getAttribute("user");

if(user != null){
%>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/voter/dashboard">
Dashboard
</a>
</li>

<li class="nav-item">
<a class="nav-link text-danger"
href="<%=request.getContextPath()%>/logout">
Logout
</a>
</li>

<%
}else{
%>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/login">
Login
</a>
</li>

<li class="nav-item">
<a class="nav-link"
href="<%=request.getContextPath()%>/register">
Register
</a>
</li>

<%
}
%>

</ul>

</div>
</div>
</nav>
>>>>>>> recovery-branch
