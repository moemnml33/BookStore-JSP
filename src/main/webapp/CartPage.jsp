<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mycartpackage.Cart" %>
<%@ page import="mycartpackage.CartItem" %>
<%@ page import="mybookpackage.Book" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="Styles.css">
    <title>My Shopping Cart</title>
</head>
<body>
	<div>
	    <h1>My Shopping Cart</h1>
	    
	    <%
	 		// retrieve cart from session
	        Cart cart = (Cart) session.getAttribute("cart");
	        
	 		// handle POST for updating quantity or removing an item
	        if (request.getMethod().equalsIgnoreCase("post")) {
	            String bookTitle = request.getParameter("bookTitle");
	            String quantityStr = request.getParameter("quantity");

	            if (cart != null && bookTitle != null) {
	            	// temp variables
	                Book bookToUpdate = null;
	                CartItem itemToRemove = null;
					// find book to update or remove
	                for (CartItem item : cart.getItems()) {
	                    if (item.getBook().getName().equals(bookTitle)) {
	                        bookToUpdate = item.getBook();
	                        itemToRemove = item;
	                        break;
	                    }
	                }

	                // remove
	                if (request.getParameter("remove") != null) {
	                    // remove item from cart
	                    if (itemToRemove != null) {
	                        cart.removeItem(itemToRemove);
	                    }
	                // update
	                } else if (quantityStr != null) {
	                    // update quantity
	                    int quantity = Integer.parseInt(quantityStr);
	                    if (bookToUpdate != null) {
	                        cart.updateItem(bookToUpdate, quantity);
	                    }
	                }
	            }
	        }
	    %>
			
	    <%	// if cart is not null/empty display table
	        if (cart != null && !cart.getItems().isEmpty()) {
	    %>
	        <table class="book-item">
	            <tr>
	                <th>Type</th>
	                <th>Price</th>
	                <th>Quantity</th>
	                <th>Total</th>
	                <th>Action</th>
	            </tr>
	        <%
	            // dynamic displaying
	            for (CartItem item : cart.getItems()) {
	                Book book = item.getBook();
	                int quantity = item.getQuantity();
	                double totalPrice = book.getPrice() * quantity;

	                // display items with a quantity greater than zero only
	                if (quantity > 0) {
	        %>
	            <tr>
	                <td><%= book.getName() %></td>
	                <td>$<%= String.format("%.2f", book.getPrice()) %></td>
	                <td>
	                    <form method="post" action="CartPage.jsp">
	                        <input type="number" name="quantity" value="<%= quantity %>" min="1"/>
	                        <input type="hidden" name="bookTitle" value="<%= book.getName() %>">
	                        <button type="submit">Update</button>
	                    </form>
	                </td>
	                <td>$<%= String.format("%.2f", totalPrice) %></td>
	                <td>
	                    <form method="post" action="CartPage.jsp">
	                        <input type="hidden" name="bookTitle" value="<%= book.getName() %>">
	                        <button type="submit" name="remove">Remove</button>
	                    </form>
	                </td>
	            </tr>
	        <%
	                }
	            }
	        %>
	        </table>
	    <%  // else display cart is empty
	        } else {
	    %>	 
	        <p class="book-item">Your cart is empty.</p>
	    <%
	        }
	    %>
	    
	    <a href="BrowsePage.jsp">Continue Shopping</a>     
	    <button>Checkout</button>
	</div>
</body>
</html>
