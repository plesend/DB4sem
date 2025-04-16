CREATE TABLE СТУДЕНТЫ (
    ID_Студента INT PRIMARY KEY, 
    Фамилия VARCHAR(100) NOT NULL,           
    Имя VARCHAR(100) NOT NULL,                 
    Отчество VARCHAR(100),                  
    Адрес VARCHAR(255),                       
    Телефон VARCHAR(20)                     
);


CREATE TABLE ПРЕДМЕТ (
    ID_Предмета INT PRIMARY KEY,
    Название VARCHAR(255) NOT NULL,        
    Лекции_ч INT NOT NULL,                    
    Практика_ч INT NOT NULL,                   
    Лабораторные_ч INT NOT NULL               
);


CREATE TABLE ОЦЕНКИ (
    ID_Записи INT PRIMARY KEY,
    ID_Студента INT NOT NULL,                  
    ID_Предмета INT NOT NULL,                  
    Оценка INT NOT NULL,                     
);