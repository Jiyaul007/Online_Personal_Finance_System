create database pfmsdemo;
use pfmsdemo;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);
CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(10, 2),
    liabilities DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE income_source (
    source_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    source_name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE income (
    income_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_id INT,
    income_date DATE,
    income_source VARCHAR(100),
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

CREATE TABLE expense_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
    category_name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE expense (
	expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_id INT,
    expense_date DATE,
    expense_category VARCHAR(100),
    remark VARCHAR(100),
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);


delimiter //
create trigger beforeAccountdelete
before delete on account
for each row

begin
	if OLD.account_id is not null THEN
		delete from expense where account_id = OLD.account_id;
		delete from income where account_id = OLD.account_id;
        delete from transaction where account_id = OLD.account_id;
	END IF;
end;
//

delimiter ;
    


CREATE TABLE transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    type varchar(10),
    amount decimal(10,2),
	statement VARCHAR(255),
    time TIMESTAMP,
    foreign key (account_id) references account(account_id)
);


DELIMITER //

CREATE TRIGGER afterIncomeInsert
AFTER INSERT ON income
FOR EACH ROW
BEGIN
    INSERT INTO transaction(account_id, type, amount,statement, time) VALUES 
        (NEW.account_id, 'Income',NEW.amount,CONCAT('Income recorded: ', NEW.income_source, ' - Amount: ', NEW.amount), CURRENT_TIMESTAMP);
END;
//

CREATE TRIGGER afterExpenseInsert
AFTER INSERT ON expense
FOR EACH ROW
BEGIN
    INSERT INTO transaction(account_id, type, amount, statement, time) VALUES 
        (NEW.account_id, 'Expense',NEW.amount, CONCAT('Expense recorded: ', NEW.expense_category, ' - Amount: ', NEW.amount), CURRENT_TIMESTAMP);
END;

//

DELIMITER ;

CREATE TABLE budget (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    expense_category VARCHAR(100),
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE target_amount (
    target_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);
