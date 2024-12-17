package mycartpackage;

import mybookpackage.Book;
import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;
    
    public Cart() {
        items = new ArrayList<>();
    }

    public void addItem(Book book, int quantity) {
        for (CartItem item : items) {
        	// if book already in cart
            if (item.getBook().getName().equals(book.getName())) {
                // update quantity and return
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        // if not found, add a new CartItem
        items.add(new CartItem(book, quantity));
    }

    public List<CartItem> getItems() {
        return items;
    }
    
    public void updateItem(Book book, int quantity) {
        for (CartItem item : items) {
        	// update quantity if the book is already in the cart
            if (item.getBook().getName().equals(book.getName())) {
                item.setQuantity(quantity);
                return;
            }
        }
    }
    
    public void removeItem(CartItem item) {
        items.remove(item);
    }
}
