-- Drop the payment_app database
DROP DATABASE IF EXISTS payment_app;
-- Create the payment_app database
CREATE DATABASE IF NOT EXISTS payment_app;
USE payment_app;

-- Create the users table with default_currency column
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NULL,
    full_name VARCHAR(100),
    date_of_birth DATE,
    phone_number VARCHAR(20) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    default_currency VARCHAR(3) -- Default currency code (e.g., USD, EUR)
);

-- Create the wallets table
CREATE TABLE IF NOT EXISTS wallets (
    wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id varchar(255) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Create the transactions table with receiver_amount and sender_amount columns
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id varchar(255) NULL,
    receiver_id varchar(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL, -- Currency code (e.g., USD, EUR)
    isCurrentUserRequest BOOLEAN NOT NULL, -- TRUE if it's a user request, FALSE otherwise
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usd_amt DECIMAL(10, 2) NOT NULL, -- Amount in USD
    receiver_amount DECIMAL(10, 2) NOT NULL, -- Amount received in receiver's default currency
    sender_amount DECIMAL(10, 2) NULL, -- Amount sent in sender's default currency
    is_top_up BOOLEAN DEFAULT FALSE, -- TRUE if it's a top up transaction, FALSE otherwise
    FOREIGN KEY (sender_id) REFERENCES users (user_id),
    FOREIGN KEY (receiver_id) REFERENCES users (user_id)
);

-- Sample insert statements for users with different default currencies
INSERT INTO users (user_id, username, email, full_name, date_of_birth, phone_number, default_currency)
VALUES
    ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'user1', 'user1@test.com', 'User One', '1990-01-15', '123-456-7890', 'USD'),
    ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 'user2', 'user2@test.com', 'User Two', '1985-05-20', '987-654-3210', 'MYR'),
    ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'user3', 'user3@test.com', 'User Three', '1998-12-10', '555-123-4567', 'SGD'),
    ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'user4', 'user4@test.com', 'User Four', '1995-08-25', '111-222-3333', 'USD');

-- Sample insert statements to create wallets for users
INSERT INTO wallets (user_id, balance)
VALUES
    ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 1000.00),
    ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 500.00),
    ('7f4TmxUfwzXkneJUj1GPZslLdA63', 750.00),
    ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 750.00);

-- Sample insert statements for transactions
-- User 1 sends $100 (USD) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 100.00, 'USD', TRUE, 100.00, 465.50, 100.00);

-- User 2 sends €50 (EUR) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', '7f4TmxUfwzXkneJUj1GPZslLdA63', 50.00, 'EUR', TRUE, 58.50, 58.50, 50.00);

-- User 3 sends £30 (GBP) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 30.00, 'GBP', TRUE, 39.00, 39.00, 30.00);

-- User 4 sends $75 (USD) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 75.00, 'USD', TRUE, 75.00, 75.00, 75.00);

-- User 1 sends €40 (EUR) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', '7f4TmxUfwzXkneJUj1GPZslLdA63', 40.00, 'EUR', TRUE, 46.80, 46.80, 40.00);

-- User 2 sends $50 (USD) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 50.00, 'USD', TRUE, 50.00, 50.00, 50.00);

-- User 3 sends £25 (GBP) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 25.00, 'GBP', TRUE, 32.50, 32.50, 25.00);

-- User 4 sends $60 (USD) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 60.00, 'USD', TRUE, 60.00, 60.00, 60.00);

-- User 1 sends $30 (USD) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 30.00, 'USD', TRUE, 30.00, 30.00, 30.00);

-- User 2 sends €20 (EUR) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', '7f4TmxUfwzXkneJUj1GPZslLdA63', 20.00, 'EUR', TRUE, 23.40, 23.40, 20.00);

-- User 3 sends £15 (GBP) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 15.00, 'GBP', TRUE, 19.50, 19.50, 15.00);

-- User 4 sends $45 (USD) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 45.00, 'USD', TRUE, 45.00, 45.00, 45.00);

-- User 1 sends €25 (EUR) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 25.00, 'EUR', TRUE, 29.25, 29.25, 25.00);

-- User 2 sends $55 (USD) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', '7f4TmxUfwzXkneJUj1GPZslLdA63', 55.00, 'USD', TRUE, 55.00, 55.00, 55.00);

-- User 3 sends £20 (GBP) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 20.00, 'GBP', TRUE, 26.00, 26.00, 20.00);

-- User 4 sends $70 (USD) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 70.00, 'USD', TRUE, 70.00, 70.00, 70.00);

-- User 1 sends €35 (EUR) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', '7f4TmxUfwzXkneJUj1GPZslLdA63', 35.00, 'EUR', TRUE, 40.95, 40.95, 35.00);

-- User 2 sends $40 (USD) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 40.00, 'USD', TRUE, 40.00, 40.00, 40.00);

-- User 3 sends £10 (GBP) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 10.00, 'GBP', TRUE, 13.00, 13.00, 10.00);

-- User 4 sends $80 (USD) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 80.00, 'USD', TRUE, 80.00, 80.00, 80.00);

-- User 1 sends $20 (USD) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 20.00, 'USD', TRUE, 20.00, 20.00, 20.00);

-- User 2 sends €30 (EUR) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', '7f4TmxUfwzXkneJUj1GPZslLdA63', 30.00, 'EUR', TRUE, 34.80, 34.80, 30.00);

-- User 3 sends £30 (GBP) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 30.00, 'GBP', TRUE, 39.00, 39.00, 30.00);

-- User 4 sends $25 (USD) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 25.00, 'USD', TRUE, 25.00, 25.00, 25.00);

-- User 1 sends €15 (EUR) to User 2
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 'iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 15.00, 'EUR', TRUE, 17.55, 17.55, 15.00);

-- User 2 sends $35 (USD) to User 3
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', '7f4TmxUfwzXkneJUj1GPZslLdA63', 35.00, 'USD', TRUE, 35.00, 35.00, 35.00);

-- User 3 sends £15 (GBP) to User 4
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('7f4TmxUfwzXkneJUj1GPZslLdA63', 'xIpAIQpOUjedRqprzfuLDNRS0pN2', 15.00, 'GBP', TRUE, 19.50, 19.50, 15.00);

-- User 4 sends $90 (USD) to User 1
INSERT INTO transactions (sender_id, receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, sender_amount)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 'U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 90.00, 'USD', TRUE, 90.00, 90.00, 90.00);

-- User 4 top up
INSERT INTO transactions (receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, is_top_up)
VALUES ('xIpAIQpOUjedRqprzfuLDNRS0pN2', 90.00, 'USD', TRUE, 90.00, 90.00, TRUE);

-- User 1 top up
INSERT INTO transactions (receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, is_top_up)
VALUES ('U8VOJgTXv5Q4UGnGZ6EZ7d7qlxF3', 90.00, 'USD', TRUE, 90.00, 90.00, TRUE);

-- User 2 top up
INSERT INTO transactions (receiver_id, amount, currency, isCurrentUserRequest, usd_amt, receiver_amount, is_top_up)
VALUES ('iMKGMhyX3kfIQuLW8nEhDn4dbNV2', 90.00, 'USD', TRUE, 90.00, 90.00, TRUE);

