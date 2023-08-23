#!/bin/bash

echo -e "\n~~~~~ Welcome to Athletic e-shop"

PSQL="psql -X --username=psymon --dbname=athletik_e_shop --tuples-only -c"

#get products catalog
CATALOG=$($PSQL "SELECT * FROM products ORDER BY product_id;")

#amount counter
AMOUNT=0.0


#read email
echo -e "\nPlease insert your email:\n"
read INSERTED_EMAIL

#get customer_id of email
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE e_mail='$INSERTED_EMAIL'" )
#if customer does not exist
if [[ -z $CUSTOMER_ID ]]
  then
  echo -e "\nSo you 're a new customer, please tell me your name?\n"
  read NEW_CUSTOMER_NAME
				  
  echo -e "\nNow tell me your last name\n"
  read NEW_LAST_NAME
				  
  echo -e "\nI also need you address so we can proceed with your order\n"
  read NEW_ADDRESS
				  
  #insert new customer
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(first_name, last_name, e_mail, address) VALUES('$NEW_CUSTOMER_NAME', '$NEW_LAST_NAME', '$INSERTED_EMAIL', '$NEW_ADDRESS');")
  else
  #get customer_name
  CUSTOMER_NAME=$($PSQL "SELECT first_name FROM customers WHERE e_mail='$INSERTED_EMAIL'")
  echo -e "\nWelcome back $CUSTOMER_NAME "
fi
				
#get customer_id for the order
ORDER_CUSTOMER_ID=$($PSQL "SELECT customer_id FROM CUSTOMERS WHERE e_mail='$INSERTED_EMAIL'")
				 
#display catalog
CATALOG_MENU() {
	echo "$CATALOG" | while IFS='|' read -r PRODUCT_ID NAME DESCRIPTION PRICE STOCK
	do
  	echo -e "\n$PRODUCT_ID) $NAME

	DESCRIPTION:
  		$DESCRIPTION

	PRICE:
  		$PRICE

	STOCK:
		$STOCK
	========================="
	done
}

CATALOG_MENU

PICK_ITEMS() {
	#choose item
	echo -e "\nPlease pick an item"
	read ITEM_PICKED
	
	#if picked item does not exist
	if [[ ! $ITEM_PICKED =~ ^[1-9]$|^10$ ]];
	then
	  echo "There is no such item. Please try agian."	
	  PICK_ITEMS
	else
	  
	  #get stock of item
	  ITEM_STOCK=$($PSQL "SELECT stock FROM products WHERE product_id='$ITEM_PICKED'")
	  
	  #check stock
	  if [[ $ITEM_STOCK -eq 0 ]]
	  then
	    echo -e "\nI 'm sorry but we 're out of stock :(\n"
	    PICK_ITEMS
	  fi
	  
	  #choose quantity 
	  echo -e "\nHow much will you need?\n"
	  read QUANTITY
	  
	  #check if there is enough stock
	  if [[ $QUANTITY -gt $ITEM_STOCK ]]
	  then
	    echo -e "\nThere is not enough stock"
	    PICK_ITEMS
	  fi
	  
	#update stock
	ITEM_STOCK=$(echo "$ITEM_STOCK - $QUANTITY" | bc)
        UPDATE_STOCK=$($PSQL "UPDATE products SET stock='$ITEM_STOCK' WHERE product_id='$ITEM_PICKED'")  
        
        #get price of item
	ITEM_PRICE=$($PSQL "SELECT price FROM products where product_id='$ITEM_PICKED'")
	echo -e "price: $ITEM_PRICE" 
	  
	#total amount untill now
	AMOUNT=$(echo "$AMOUNT + $ITEM_PRICE * $QUANTITY" | bc)
	echo -e "amount untill now $AMOUNT"
	  
	fi
	
}
PICK_ITEMS

	 #insert order data
	 INSERT_ORDER_DATA=$($PSQL "INSERT INTO orders(customer_id, total_amount) VALUES('$ORDER_CUSTOMER_ID','$AMOUNT')")
				
	 #get order id
	 ITEM_ORDER_ID=$($PSQL "SELECT order_id FROM orders ORDER BY order_id DESC LIMIT 1;");
	 
				
ANYTHING_ELSE() {
while true; 
do
	echo -e "\nWould you like anything else? (Yes/No)"
	read ANSWER

	case "$ANSWER" in
	[Yy][Ee][Ss])
			  
			  	
	#insert data in order_items
	INSERT_ORDER_ITEMS=$($PSQL "INSERT INTO order_items(order_id, product_id, quantity, unit_price) VALUES($ITEM_ORDER_ID, $ITEM_PICKED, $QUANTITY, $ITEM_PRICE)")
	  			
	echo -e "\nGo on"
	PICK_ITEMS
				
	#update order table
	UPDATE_ORDER=$($PSQL "UPDATE orders SET total_amount='$AMOUNT' WHERE order_id='$ITEM_ORDER_ID'")
        			
	ANYTHING_ELSE
				
	break
	;;
	[Nn][Oo])
			  
	#insert data in order_items
	INSERT_ORDER_ITEMS=$($PSQL "INSERT INTO order_items(order_id, product_id, quantity, unit_price) VALUES($ITEM_ORDER_ID, $ITEM_PICKED, $QUANTITY, $ITEM_PRICE)")
	  			
	echo -e "Thank you for the preference"
	ADDING_ITEMS=false
	break
	;;
	*)
	echo -e "\nInvalid answer. Please try again."
	;;
	esac
done
}
ANYTHING_ELSE

#vie cart
echo -e "\nLet 's view your cart\n"
GET_CHART=$($PSQL "SELECT name, description, quantity, unit_price FROM orders INNER JOIN order_items USING(order_id) INNER JOIN products USING(product_id) WHERE order_id='$ITEM_ORDER_ID';")

echo "$GET_CHART" | while IFS='|' read -r NAME DESCRIPTION QUANTITY UNIT_PRICE
do
echo "product: $NAME | description: $DESCRIPTION | pieces: $QUANTITY | price per item: $UNIT_PRICE"
done
echo -e "\n---------------------------------\n                            Total: $AMOUNT"


#paying method	
PAYING_METHOD() {

echo -e "\n(a)Cash on delivery OR (b)pay with debit card?\n"
read PAYING

while true; 
do
	case "$PAYING" in
	[Aa])
	echo -e "\nGreat your package will be delivered to your address in 3-5 days. Thank you for the preference :)"
	
	break
	;;
	[Bb])
	echo -e "\nPlease enter your credit card number\n"
	read CREDIT_NUMBER
	
	echo -e "\nPlease enter your fullname\n"
	read FULL_NAME
	
	echo -e "\nexp.Date\n"
	read EXP_DATE
	
	echo -e "\nCV\n"
	read CV
	
	echo -e "\nYour payment is completed. Your package will be delivered to your address in 3-5 days. Thank you for the preference :)\n"
	break
	;;
	*)
	echo -e "\nInvalid answer. Please try again.\n"
	PAYING_METHOD
	;;
	esac
done
}
PAYING_METHOD
