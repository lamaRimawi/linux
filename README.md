# Linux System Administration Tools

A collection of Linux system administration scripts, configurations, and automation tools for efficient server management and daily operations.

## Overview

This repository contains a comprehensive set of Linux administration tools designed to automate common system tasks, monitor system health, and streamline server management workflows. Perfect for system administrators, DevOps engineers, and Linux enthusiasts.

## Features

- 🖥️ **System Monitoring** - Scripts to monitor CPU, memory, disk usage, and system performance
- 🔒 **Security Tools** - Security hardening scripts and configuration templates
- 📊 **Log Analysis** - Automated log parsing and analysis utilities
- 🚀 **Automation Scripts** - Task automation for common admin operations
- 📁 **Backup Solutions** - Automated backup and recovery scripts
- 🌐 **Network Tools** - Network diagnostics and configuration utilities
- 🔧 **Server Setup** - Configuration templates for various Linux services

## Project Structure

```
linux/
├── scripts/
│   ├── monitoring/          # System monitoring scripts
│   ├── security/           # Security and hardening tools
│   ├── backup/             # Backup and recovery scripts
│   ├── automation/         # Task automation utilities
│   └── network/            # Network administration tools
├── configs/
│   ├── apache/             # Apache configuration templates
│   ├── nginx/              # Nginx configuration examples
│   ├── ssh/                # SSH security configurations
│   └── firewall/           # Firewall rules and settings
├── docs/
│   ├── installation.md     # Setup instructions
│   ├── usage.md            # Usage guidelines
│   └── troubleshooting.md  # Common issues and solutions
└── examples/               # Example implementations
```

## Quick Start

### System Requirements
- Linux distribution (Ubuntu 18.04+, CentOS 7+, RHEL 7+)
- Bash shell (4.0+)
- Root or sudo privileges for system administration tasks

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/lamaRimawi/linux-sysadmin-tools.git
   cd linux-sysadmin-tools
   ```

2. **Make scripts executable:**
   ```bash
   chmod +x scripts/**/*.sh
   ```

3. **Run initial setup:**
   ```bash
   ./setup.sh
   ```

## Core Scripts

### System Monitoring
```bash
# Check system health
./scripts/monitoring/system_health.sh

# Monitor disk usage
./scripts/monitoring/disk_monitor.sh

# Memory usage report
./scripts/monitoring/memory_check.sh
```

### Automated Backups
```bash
# Database backup
./scripts/backup/db_backup.sh

# File system backup
./scripts/backup/fs_backup.sh

# Log rotation and cleanup
./scripts/backup/log_cleanup.sh
```

### Security Tools
```bash
# System hardening
./scripts/security/harden_system.sh

# User audit
./scripts/security/user_audit.sh

# Port scanner
./scripts/security/port_scan.sh
```

## Configuration Examples

### Apache Virtual Host
```apache
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/html/example
    ServerAlias www.example.com
    
    ErrorLog ${APACHE_LOG_DIR}/example_error.log
    CustomLog ${APACHE_LOG_DIR}/example_access.log combined
</VirtualHost>
```

### Nginx Server Block
```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    root /var/www/html/example;
    index index.html index.php;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

## Automation Examples

### Cron Job Setup
```bash
# Daily system health check
0 6 * * * /path/to/scripts/monitoring/daily_report.sh

# Weekly backup
0 2 * * 0 /path/to/scripts/backup/weekly_backup.sh

# Monthly log cleanup
0 3 1 * * /path/to/scripts/maintenance/log_cleanup.sh
```

### Service Management
```bash
# Restart service if down
./scripts/automation/service_monitor.sh apache2

# Update system packages
./scripts/automation/system_update.sh

# Deploy application
./scripts/automation/app_deploy.sh /path/to/app
```

## Usage Examples

### System Information
```bash
# Get comprehensive system info
./scripts/monitoring/system_info.sh

# Check service status
./scripts/monitoring/service_status.sh nginx mysql

# Monitor real-time performance
./scripts/monitoring/realtime_monitor.sh
```

### Security Audit
```bash
# Run security audit
./scripts/security/security_audit.sh

# Check for rootkits
./scripts/security/rootkit_check.sh

# Analyze failed login attempts
./scripts/security/login_analysis.sh
```

## Advanced Features

### Custom Monitoring Dashboard
- Real-time system metrics
- Alert notifications via email
- Historical performance graphs
- Custom threshold settings

### Automated Deployment
- Zero-downtime deployments
- Configuration management
- Rollback capabilities
- Health checks

### Disaster Recovery
- Automated backup verification
- Recovery procedures
- System state snapshots
- Documentation generation

## Best Practices

### Script Development
- Use proper error handling and logging
- Include help documentation (`--help` flag)
- Validate input parameters
- Follow security best practices

### System Administration
- Regular system updates and patches
- Monitor system resources continuously
- Implement proper backup strategies
- Document all configurations and procedures

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-tool`)
3. Commit your changes (`git commit -am 'Add new monitoring tool'`)
4. Push to the branch (`git push origin feature/new-tool`)
5. Create a Pull Request

### Contribution Guidelines
- Follow existing code style and conventions
- Include documentation for new scripts
- Add examples and usage instructions
- Test scripts on multiple distributions when possible

## Troubleshooting

### Common Issues
- **Permission denied**: Ensure scripts have execute permissions
- **Command not found**: Check if required packages are installed
- **Configuration errors**: Validate syntax before applying changes

### Support
- Check the `docs/troubleshooting.md` for common solutions
- Review script logs in `/var/log/sysadmin-tools/`
- Open an issue for bugs or feature requests

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Lama Rimawi**  
GitHub: [@lamaRimawi](https://github.com/lamaRimawi)

## Acknowledgments

- Linux community for best practices and tools
- Open source projects that inspired these scripts
- System administrators who shared their expertise

---

**⚠️ Important**: Always test scripts in a development environment before using in production. Some scripts require root privileges and can make system-wide changes.
