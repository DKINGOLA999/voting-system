<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Votify</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* GLOBAL THEME */
body{
  font-family:'Segoe UI',sans-serif;
  background: linear-gradient(135deg,#0a1f44,#000000);
}

/* GLASS EFFECT */
.glass{
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255,255,255,0.1);
}

/* CARD SYSTEM */
.card, .main-card{
  border-radius:16px;
  transition:0.3s;
  box-shadow:0 10px 40px rgba(0,0,0,0.3);
}

.card:hover{
  transform: translateY(-5px);
}

/* BUTTON SYSTEM */
.btn{
  border-radius:25px;
  transition:0.3s;
  font-weight:500;
}

.btn:hover{
  transform:scale(1.05);
}

/* PRIMARY BUTTON */
.btn-primary{
  background:#0a1f44;
  border:none;
}

.btn-primary:hover{
  background:black;
}

/* FORM */
.form-control{
  border-radius:10px;
  padding:12px;
}

/* NAVBAR SCROLL EFFECT */
.navbar-scrolled{
  background: rgba(10,31,68,0.85) !important;
  backdrop-filter: blur(12px);
}

/* FOOTER */
.footer-dark{
  background:#020617;
}

/* TEXT */
.text-soft{
  color:#cbd5e1;
}

</style>