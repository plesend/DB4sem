CREATE TABLE �������� (
    ID_�������� INT PRIMARY KEY, 
    ������� VARCHAR(100) NOT NULL,           
    ��� VARCHAR(100) NOT NULL,                 
    �������� VARCHAR(100),                  
    ����� VARCHAR(255),                       
    ������� VARCHAR(20)                     
);


CREATE TABLE ������� (
    ID_�������� INT PRIMARY KEY,
    �������� VARCHAR(255) NOT NULL,        
    ������_� INT NOT NULL,                    
    ��������_� INT NOT NULL,                   
    ������������_� INT NOT NULL               
);


CREATE TABLE ������ (
    ID_������ INT PRIMARY KEY,
    ID_�������� INT NOT NULL,                  
    ID_�������� INT NOT NULL,                  
    ������ INT NOT NULL,                     
);