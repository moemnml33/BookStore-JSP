<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mybookpackage.Book" %>
<%@ page import="mycartpackage.Cart" %>
<%@ page import="mycartpackage.CartItem" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="Styles.css">
    <title>Browse Page</title>
</head>
<body>
	<h1>Your Shopping Cart</h1>
	<h2>Available Books</h2>
	<ul class="book-list">
	    <%
	        // create list of books
	        ArrayList<Book> bookList = new ArrayList<>();
	        bookList.add(new Book("Design Patterns: Elements of Reusable Object-Oriented Software", 59.99));
	        bookList.add(new Book("Patterns of Enterprise Application Architecture", 47.99));
	        bookList.add(new Book("Node.js Design Patterns", 39.99));
	        
	        // retrieve cart from session or create a new one
	        Cart cart = (Cart) session.getAttribute("cart");
	        if (cart == null) {
	            cart = new Cart();
	            session.setAttribute("cart", cart);
	        }
	        
	        // handle POST
	        if ("POST".equalsIgnoreCase(request.getMethod())) {
	            String bookTitle = request.getParameter("bookTitle");
	            String bookPrice = request.getParameter("bookPrice");
	            String quantityStr = request.getParameter("quantity");
	            
	            // if available add book to cart
	            if (bookTitle != null && bookPrice != null && quantityStr != null) {
	                int quantity = Integer.parseInt(quantityStr); // parse qty int
	                for (Book book : bookList) {
	                    if (book.getName().equals(bookTitle)) {
	                        cart.addItem(book, quantity);
	                        break;
	                    }
	                }
	            }
	        }
	
	        // dynamic displaying
	        for (int i = 0; i < bookList.size(); i++) {
	            Book book = bookList.get(i);
	    %>
	            <li class="book-item">
	                <p class="book-header">
	                    <span class="book-title"><%= book.getName() %></span>
	                    <span class="book-price">$<%= String.format("%.2f", book.getPrice()) %></span>
	                </p>
	                <div>
	                    <form method="post" action="BrowsePage.jsp">
	                        <label for="quantity-<%=i%>">Quantity:</label>
	                        <input type="number" id="quantity-<%=i%>" name="quantity" min="1" value="1" required>
	                        <input type="hidden" name="bookTitle" value="<%= book.getName() %>">
	                        <input type="hidden" name="bookPrice" value="<%= book.getPrice() %>">
	                        <button class="add-to-cart" type="submit">Add to Cart</button>
	                    </form>
	                </div>
	            </li>
	    <%
	        }
	    %>
	</ul>
	
	<div class="cart-icon">
	    <a href="CartPage.jsp">
	        <img src="assets/shoppingcart.png" alt="Shopping Cart">
	        Items in Cart
	    </a>        
	</div>
</body>
</html>
