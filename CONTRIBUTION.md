# Contributing to CMDtask

Thank you for your interest in contributing! This project aims to provide a simple, colorful, terminal-based task manager with due-date tracking, priorities, and an easy menu interface. Contributions of all kinds are welcome.

## How to Contribute

### 1. Fork the Repository
Create your own fork of the project to work on changes safely.

### 2. Clone Your Fork
```git clone https://github.com/your-username/CMDtask.git``` 
```cd CMDtask```

### 3. Create a Feature Branch
```git checkout -b feature-name```

### 4. Make Your Changes
Possible contributions include:
- Adding new task-management capabilities  
- Improving due-date processing  
- Enhancing menu navigation and interface output  
- Fixing bugs or unexpected behavior  
- Updating or adding documentation  

Ensure all existing functionality continues to work.

### 5. Test the Script
Run the task manager:

```./CMDtask.sh```

Verify that:
- Tasks display correctly  
- New tasks save properly to ~/.tasks  
- Completion and removal work  
- Due reminders still appear when the script starts  

### 6. Commit Your Changes
```git add .```  
```git commit -m "Describe your change clearly"```

### 7. Push and Submit a Pull Request
```git push origin feature-name```

Open a pull request describing:
- What was changed  
- Why it improves the project  
- How to test it  

## Coding Style

- Follow the existing style and structure in CMDtask.sh  
- Keep Bash code clear and consistent  
- Avoid unnecessary complexity  
- Maintain compatibility with basic bash environments  

## Requirements Reminder

The script depends on:
- bash  
- figlet  
- lolcat (optional)

New features should behave gracefully if optional tools are unavailable.

## Reporting Issues

If you encounter bugs or want to request features:
1. Check existing issues first  
2. Open a new issue including:  
   - A clear explanation  
   - Steps to reproduce (if applicable)  
   - Expected vs. actual behavior  

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
