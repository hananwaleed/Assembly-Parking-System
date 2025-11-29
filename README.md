# Parking Management System 

## 📌 Project Overview
This project is a Parking Management System developed entirely in **8086 Assembly language**.  
The main goal is to simulate a real parking lot environment using low-level programming concepts, where every operation is manually controlled through registers, memory, and DOS interrupts.

The system runs through a **text-based menu** that allows the user to manage parking operations efficiently, display records, track income, and monitor the capacity of the parking lot.  
It is designed to be simple, fast, and educational — especially for students learning Assembly or working on low-level system design.

---

## 🚗 System Purpose
The parking system emulates the core functions of a real parking area:

- Managing different types of vehicles  
- Tracking how many spaces are occupied  
- Ensuring the maximum capacity is not exceeded  
- Calculating total income based on fixed parking charges  
- Providing clear feedback and status messages to the user  

The main idea is to teach how logic, conditions, counters, and data flow are implemented in Assembly language.

---

## 🧠 Why Assembly Language?
Assembly is one of the closest languages to the hardware level.  
This project demonstrates:

- How to handle user input manually  
- How to control program flow without high-level structures  
- How memory, registers, and interrupts work together  

It helps learners understand what happens “behind the scenes” in higher-level languages.

---

## ⚙️ Main Features of the System

### **1. Vehicle Parking**
The system allows parking different types of vehicles, each with its own fixed charge.  
Whenever a vehicle is added:

- The total vehicle count increases  
- The vehicle-type counter (Rikshaw / Car / Bus) updates  
- The income increases  
- The system checks if the lot is full before adding more vehicles  

---

### **2. Vehicle Removal**
The user can remove any type of vehicle.  
When removed:

- The specific counter decreases  
- Total occupied spaces update  
- The system checks that the type is not already zero  

This simulates a vehicle leaving the parking area.

---

### **3. Displaying Records**
The system displays a full summary:

- Total income collected  
- Total vehicles currently parked  
- Count of rikshaws  
- Count of cars  
- Count of buses  

A clear snapshot of the parking status anytime.

---

### **4. Parking Capacity Status**
The system monitors:

- **Occupied slots**  
- **Available slots** (calculated from max capacity)

If the lot is full, it prevents any new vehicle from being added.

---

### **5. Reset System**
A full reset option clears:

- All counters  
- Total income  

This returns the system to its initial empty state, useful for testing or starting a fresh session.

---

## 🖥️ User Interface & Experience
The project uses a simple **text-based interface** that works in any DOS environment.  
The menu is designed for:

- Clarity  
- Simplicity  
- Quick interaction  

Each operation gives instant feedback such as:

- “Operation Successful”  
- “Parking Full”  
- “No Vehicles to Remove”  
- “Records Updated”  

Despite being low-level, the UI is intuitive and efficient.

---

## 🧩 Technical Concepts Demonstrated
This project helps practice and demonstrate:

- Data storage using memory variables  
- Flow control using conditional jumps  
- User input via keyboard interrupts  
- Screen output through DOS functions  
- Arithmetic on ASCII values  
- Counters, loops, and structured assembly logic  

It reflects real-world logic implemented with low-level instructions.

---

## 🎯 Educational Goals
By building and studying this project, the learner gains experience in:

- Designing full systems in Assembly  
- Applying computer architecture concepts  
- Handling real-time user input  
- Producing dynamic output  
- Understanding how high-level systems operate internally  

Perfect for courses in:

- Assembly Language  
- Computer Architecture  
- Systems Programming  
- Embedded System Fundamentals  

---

## 📂 Project Contents
The repository includes:

- Full documentation of the system  
- Main assembly source file (`.asm`)  
- A runnable executable (optional)  
- Notes and supporting explanations  

---

## 🛠 Tools & Environment Used

- **TASM** (Turbo Assembler)   
- `.model small` architecture  

Compatible with standard 8086 environments.

---

##  Future Enhancements
Possible upgrades for extending the project:

- Time-based parking fees  
- Saving session data to an external file  
- Adding a graphical interface  
- Admin login / authentication  
- Real-time clock integration  
- More vehicle categories  

---

##  Conclusion
This Parking Management System is a complete educational project built entirely in Assembly language.  
It demonstrates how low-level programming can simulate real-world systems by manually controlling every detail.



