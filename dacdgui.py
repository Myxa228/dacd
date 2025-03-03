import tkinter as tk
from tkinter import scrolledtext, messagebox
import subprocess
import os

def run_command(command, success_message, failure_message):
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        output_text.delete(1.0, tk.END) 
        if result.returncode == 0:
            output_text.insert(tk.END, success_message)  
        else:
            output_text.insert(tk.END, failure_message) 
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))

def check_internet():
    command = "ping -c 1 8.8.8.8"  
    run_command(command, "интернет нормально работает.", "интернет не работает.")

def check_ping():
    run_command("ping 8.8.8.8 -c 3", "команда ping работает", "команда ping не работает")

def check_dns():
    run_command("nslookup google.com", "DNS сервер работает", "DNS сервер не работает")

def check_disk_space():
    command = "df -h /"  # Проверка свободного места на корневом разделе
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    output_text.delete(1.0, tk.END)
    if result.returncode == 0:
    	output_text.insert(tk.END, result.stdout)

def check_file_sys():
    result = subprocess.run("sudo badblocks -v /dev/sdc", shell=True, capture_output=True, text=True)
    output_text.delete(1.0, tk.END)
    if result.returncode == 0:
        output_text.insert(tk.END, result.stdout)

def check_CPUuse():
    output_text.delete(1.0, tk.END)
    output_text.insert(tk.END, os.popen("grep 'cpu ' /proc/stat | awk '{usage = ($2+$4)*100/($2+$4+$5)} END {print usage \"%\"}'").read().strip())

root = tk.Tk()
root.title("Системный монитор")
root.geometry("600x400")

# Заголовок
tk.Label(root, text="Выберите проверку", font=("Arial", 14)).pack(pady=5)

# Кнопки для разных проверок
tk.Button(root, text="Проверить интернет", command=check_internet).pack(pady=5)
tk.Button(root, text="проверка ping до известных серверов", command=check_ping).pack(pady=5)
tk.Button(root, text="проверка DNS разрешения", command=check_dns).pack(pady=5)

tk.Button(root, text="Проверить диск", command=check_disk_space).pack(pady=5)
tk.Button(root, text="проверка целостности файловой системы\n(ВЫПОЛНЕНИЕ ЭТОЙ КОМАНДЫ ЗАНИМАЕТ НЕКОТОРОЕ ВРЕМЯ)", command=check_file_sys).pack(pady=5)

tk.Button(root, text="проверка загрузки процессора", command=check_CPUuse).pack(pady=5)

# Поле вывода результатов
output_text = scrolledtext.ScrolledText(root, width=70, height=5)
output_text.pack(pady=10)

# Запуск GUI
root.mainloop()