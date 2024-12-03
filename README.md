# wordpress_alpine-php-test-v1.0
# WordPress Alpine-PHP Test v1.0

This repository provides a **staging environment for WordPress** using Alpine-based PHP images, with placeholders for integrating additional PHP-based applications like **Mautic**. The setup is designed to handle applications on different ports (e.g., WordPress on port 9000 and Mautic or others on port 9001), making it flexible for multi-application environments.

---

## Features

- **Lightweight Alpine-based setup** for WordPress and PHP applications.
- **Docker Compose integration** for simplified container orchestration.
- **Pre-configured placeholders** for additional PHP-based applications (e.g., Mautic).
- **Secure secrets management** for environment variables like database credentials.
- **Redis caching** for performance optimization in WordPress.
- Easily extendable to add more PHP apps running on different ports.

---

## Setup and Deployment Guide

Follow these steps to clone, configure, and deploy the environment.

### Prerequisites

- Docker and Docker Compose installed on your machine.
- Basic understanding of Docker and PHP-based applications.
- Ports **9000**, **9001**, and other required ports should be available on your system.

---

### Steps to Clone and Deploy

1. **Clone the Repository**
   ```bash
   git clone https://github.com/deborahsbg/wordpress_alpine-php-test-v1.0.git
   cd wordpress_alpine-php-test-v1.0
   ```

2. **Configure Secrets**
   - Populate the `secrets` directory with required files:
     - `db_password` – Your database password.
     - `wp_admin_password` – WordPress admin password.
     - Authentication keys and salts for WordPress (`auth_key`, `secure_auth_key`, etc.).
     - `redis_password` – Password for Redis.

     Use placeholder files in the `secrets` directory as references.

3. **Customize `.env` (Optional)**
   - Update environment variables for WordPress and additional applications as needed.
   - Ensure placeholders for apps like Mautic are correctly defined.

4. **Deploy Containers**
   ```bash
   docker-compose up --build
   ```

5. **Access WordPress**
   - Navigate to your browser and open: [http://localhost](http://localhost)
   - WordPress should now be running on port **9000**.

6. **Extend for Additional Applications**
   - Update `docker-compose.yml` with additional services for other PHP-based applications (e.g., Mautic).
   - Set unique ports for each service (e.g., **9001** for Mautic).

---

### File Structure

```
wordpress_alpine-php-test-v1.0/
├── db/                        # MariaDB initialization scripts
├── nginx/                     # Nginx configuration files
├── php-test/                  # Placeholder for additional PHP apps
├── redis/                     # Redis configuration and data
├── scripts/                   # Helper scripts for deployment
├── secrets/                   # Secret files for credentials
├── wordpress/                 # WordPress-specific Dockerfiles and configurations
├── docker-compose.yml         # Docker Compose configuration
└── README.md                  # Project documentation
```

---

## Future Enhancements

- Integrate Mautic or other PHP apps seamlessly within this environment.
- Add monitoring tools (e.g., Prometheus, Grafana) for real-time performance tracking.
- Expand the setup for multi-domain configurations using Nginx.

---

## Contributing

Feel free to submit pull requests or raise issues for improvements. This project is open to contributions to improve its flexibility and usability.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

### Quick Commands Reference

- **Stop All Services**
  ```bash
  docker-compose down
  ```
- **Rebuild and Start Fresh**
  ```bash
  docker-compose up --build
  ```
- **Check Logs**
  ```bash
  docker logs <container_name>
  ```
- **Access a Container**
  ```bash
  docker exec -it <container_name> bash
  ```

---

This README should give you a comprehensive guide to deploy and extend the repository for staging WordPress and additional PHP-based applications.
