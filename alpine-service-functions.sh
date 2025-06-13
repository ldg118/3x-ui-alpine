# Alpine Linux Service Management Functions for x-ui

# Function to detect service management system
detect_service_manager() {
    if command -v systemctl >/dev/null 2>&1; then
        echo "systemd"
    elif command -v rc-service >/dev/null 2>&1; then
        echo "openrc"
    else
        echo "manual"
    fi
}

# Service control wrapper functions
service_start() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl start x-ui
            ;;
        "openrc")
            rc-service x-ui start
            ;;
        "manual")
            if ! pgrep -f "/usr/local/x-ui/x-ui" > /dev/null; then
                nohup /usr/local/x-ui/x-ui > /dev/null 2>&1 &
            fi
            ;;
    esac
}

service_stop() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl stop x-ui
            ;;
        "openrc")
            rc-service x-ui stop
            ;;
        "manual")
            pkill -f "/usr/local/x-ui/x-ui"
            ;;
    esac
}

service_restart() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl restart x-ui
            ;;
        "openrc")
            rc-service x-ui restart
            ;;
        "manual")
            pkill -f "/usr/local/x-ui/x-ui"
            sleep 2
            nohup /usr/local/x-ui/x-ui > /dev/null 2>&1 &
            ;;
    esac
}

service_status() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl status x-ui -l
            ;;
        "openrc")
            rc-service x-ui status
            ;;
        "manual")
            if pgrep -f "/usr/local/x-ui/x-ui" > /dev/null; then
                echo "x-ui is running (manual mode)"
                return 0
            else
                echo "x-ui is not running"
                return 1
            fi
            ;;
    esac
}

service_enable() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl enable x-ui
            ;;
        "openrc")
            rc-update add x-ui default
            ;;
        "manual")
            echo "Auto-start not supported in manual mode"
            ;;
    esac
}

service_disable() {
    local service_manager=$(detect_service_manager)
    case "$service_manager" in
        "systemd")
            systemctl disable x-ui
            ;;
        "openrc")
            rc-update del x-ui default
            ;;
        "manual")
            echo "Auto-start not supported in manual mode"
            ;;
    esac
}

