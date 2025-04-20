# CMDtask

A terminal-based task manager with a colorful interface, due date tracking, and priorities.

## Features

- Add tasks with title, due date (`DD/MM/YY`), and priority (`High`, `Medium`, `Low`)
- View all tasks, including completed ones
- Complete or remove tasks with a simple menu
- Automatically notifies you of due tasks at the top
- Big colorful headers and simple navigation

## Requirements

> `bash`
> >
> `figlet` (for big text)
>
> > ```npm install figlet ```
> 
> `lolcat` (optional, for colors)
>
> > ```npm install figlet```

## Installation

1. Place `CMDtask.sh` anywhere (e.g. `~/CMDtask.sh`)
2. Make it executable:
   ```
   chmod +x /CMDtask.sh
   ```
   3. (Optional) Add an alias to your .bashrc or .zshrc:
   ```
   alias CMDtask='source ~/CMDtask.sh'
   ```
   ## Usage
   ```
   ./CMDtask.sh
   ```

   ### Menu Options
- (1) View tasks – Shows all tasks, their due dates, and priorities
- (2) Add task – Enter task title, due date (DD/MM/YY), and priority
- (3) Complete task – Mark a task as completed
- (4) Remove task – Delete a task
- (5) Exit – Return to the terminal

Tasks are stored in ~/.tasks in a simple text format:

[ ]|Buy milk|19/04/25|High
[✔]|Submit report|18/04/25|Medium

## Notes
You will see upcoming due reminders at the top when the script starts.

Dates are parsed and compared in DD/MM/YY format.

## License
This project is licensed under the MIT License.
