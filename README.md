#  Terraform AWS NGINX + ALB

Este proyecto crea una infraestructura en AWS usando Terraform, pensada para servir como demo técnica o base para despliegues reales.

Incluye:
- EC2 (Amazon Linux 2) con NGINX
- Application Load Balancer (ALB)
- Auto Scaling Group
- Subnets públicas y privadas
- NAT Gateway
- GitHub Actions para despliegue automático

---

## ✅ Descripción general

La infraestructura levanta 2 instancias EC2 corriendo NGINX, distribuidas en subnets privadas y balanceadas por un Application Load Balancer expuesto al público.

Todo se gestiona como código con Terraform y puede aplicarse de forma automática mediante GitHub Actions.

---

## 🌐 Infraestructura

### Componentes:

- **VPC personalizada**
- **2 subnets públicas** (para el ALB y NAT Gateway)
- **2 subnets privadas** (para las instancias EC2)
- **Application Load Balancer** (HTTP público)
- **Auto Scaling Group** con 2 instancias EC2
- **NAT Gateway** para salida a internet de las EC2 privadas
- **Security Groups** que limitan acceso: solo el ALB puede hablar con las EC2

---

## ⚙️ Cómo desplegar

### Opción A – Terraform local

```bash
terraform init
terraform apply -auto-approve
```

🔐 Asegurate de tener configuradas tus credenciales AWS localmente con `aws configure`.

---

### Opción B – GitHub Actions (CI/CD)

1. Hacé un fork de este repo
2. Agregá tus secrets AWS en GitHub:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. Hacé un push a `main`
4. GitHub aplicará automáticamente la infraestructura desde `.github/workflows/terraform.yml`

---

## 🛡️ Decisiones técnicas

- Se optó por usar **subnets privadas para EC2**, sin IP pública, siguiendo buenas prácticas de arquitectura.
- Para permitir que las instancias privadas instalen paquetes (como NGINX), se usó un **NAT Gateway** ubicado en una subnet pública.
- Se evitó exponer directamente las EC2, garantizando que todo el tráfico pase por el ALB.
- Durante el desarrollo se testeó también una opción sin NAT Gateway, usando IP públicas + SG restringido — útil para demos de costo cero.

---

## 🧠 Cómo usarlo y probar

1. Aplicá la infraestructura con Terraform local o con GitHub Actions
2. Esperá a que el ALB esté creado y saludable (1–2 minutos)
3. Copiá la salida `alb_dns` y abrila en el navegador
4. Deberías ver: `Hola desde EC2 a través del ALB`

---

## 📦 Requisitos

- Cuenta de AWS (con permisos para crear recursos)
- Terraform CLI v1.7+
- GitHub (si usás CI/CD)
- Credenciales configuradas (localmente o en GitHub Secrets)

-----

