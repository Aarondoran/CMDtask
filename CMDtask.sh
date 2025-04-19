#!/bin/bash

TASK_FILE="$HOME/.tasks"

mkdir -p "$(dirname "$TASK_FILE")"
touch "$TASK_FILE"

function bigtext() {
    if command -v figlet >/dev/null 2>&1; then
        if command -v lolcat >/dev/null 2>&1; then
            figlet "$1" | lolcat
        else
            figlet "$1"
        fi
    else
        echo "=== $1 ==="
    fi
}

function due_reminders() {
    today=$(date +%d/%m/%y)
    reminders=$(awk -F'|' -v today="$today" '
    function d(s) {
        split(s,a,"/"); return a[3] a[2] a[1]
    }
    $1 == "[ ]" && d($3) <= d(today) { print "- " $2 }
    ' "$TASK_FILE")
    if [ -n "$reminders" ]; then
        echo
        echo "🔔 Reminders Due:" | lolcat 2>/dev/null || echo "Reminders Due:"
        echo "$reminders"
        echo
    fi
}

function show_menu() {
    clear
    bigtext "CMDtask"
    due_reminders

    echo "1) View tasks"
    echo "2) Add task"
    echo "3) Complete task"
    echo "4) Remove task"
    echo "5) Exit"
    echo ""
    read -rp "Choose an option: " choice

    case $choice in
        1) view_tasks ;;
        2) add_task ;;
        3) complete_task ;;
        4) remove_task ;;
        5) return 1 ;;  # <-- this breaks the loop below
        *) echo "Invalid choice." && sleep 1 ;;
    esac
}

function view_tasks() {
    clear
    bigtext "Your Tasks"
    due_reminders

    if [ ! -s "$TASK_FILE" ]; then
        echo "🎉 No tasks for now!" | lolcat 2>/dev/null || echo "No tasks for now!"
    else
        echo
        awk -F'|' '{ printf "%2d. %s %s [Due: %s] [Priority: %s]\n", NR, $1, $2, $3, $4 }' "$TASK_FILE"
    fi
    echo
    read -rp "Press enter to return..." _
}

function add_task() {
    clear
    bigtext "Add Task"

    read -rp "Task title: " title
    read -rp "Due date (DD/MM/YY): " due

    echo
    echo "Select Priority:"
    echo "1) High"
    echo "2) Medium"
    echo "3) Low"
    read -rp "Enter number: " priority_choice

    case "$priority_choice" in
        1) priority="High" ;;
        2) priority="Medium" ;;
        3) priority="Low" ;;
        *) echo "Invalid priority." && sleep 1 && return ;;
    esac

    if [[ -n "$title" && "$due" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{2}$ ]]; then
        echo "[ ]|$title|$due|$priority" >> "$TASK_FILE"
        echo "Task added!" | lolcat 2>/dev/null || echo "Task added!"
    else
        echo "Invalid input."
    fi
    sleep 1.5
}

function complete_task() {
    clear
    bigtext "Complete Task"

    if [ ! -s "$TASK_FILE" ]; then
        echo "No tasks to complete."
        sleep 1.5
        return
    fi

    mapfile -t lines < "$TASK_FILE"
    echo
    for i in "${!lines[@]}"; do
        IFS='|' read -r status title due priority <<< "${lines[i]}"
        echo "$((i+1)). $status $title [Due: $due] [Priority: $priority]"
    done

    echo
    read -rp "Select task number to complete: " idx
    idx=$((idx - 1))

    if [[ "$idx" -ge 0 && "$idx" -lt "${#lines[@]}" ]]; then
        IFS='|' read -r _ title due priority <<< "${lines[idx]}"
        lines[idx]="[✔]|$title|$due|$priority"
        printf "%s\n" "${lines[@]}" > "$TASK_FILE"
        echo "Marked as complete!" | lolcat 2>/dev/null || echo "Done!"
    else
        echo "Invalid choice."
    fi
    sleep 1.5
}

function remove_task() {
    clear
    bigtext "Remove Task"

    if [ ! -s "$TASK_FILE" ]; then
        echo "No tasks to remove."
        sleep 1.5
        return
    fi

    mapfile -t lines < "$TASK_FILE"
    echo
    for i in "${!lines[@]}"; do
        IFS='|' read -r status title due priority <<< "${lines[i]}"
        echo "$((i+1)). $status $title [Due: $due] [Priority: $priority]"
    done

    echo
    read -rp "Select task number to remove: " idx
    idx=$((idx - 1))

    if [[ "$idx" -ge 0 && "$idx" -lt "${#lines[@]}" ]]; then
        unset 'lines[idx]'
        printf "%s\n" "${lines[@]}" > "$TASK_FILE"
        echo "Task removed!" | lolcat 2>/dev/null || echo "Removed!"
    else
        echo "Invalid choice."
    fi
    sleep 1.5
}

while true; do
    show_menu || break
done
