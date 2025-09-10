require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    context "with valid parameters" do
      it "creates a new Book and redirects with success notice" do
        expect {
          post books_path, params: { 
            book: { 
              title: "New Test Book",
              author: "Test Author",
              price: 15.99,
              published_date: Date.today 
            } 
          }
        }.to change(Book, :count).by(1)
        
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(flash[:notice]).to eq("Book was successfully created.")
      end

      it "creates a book with all attributes and redirects with success notice" do
        expect {
          post books_path, params: { 
            book: { 
              title: "Complete Book", 
              author: "John Smith", 
              price: 29.99, 
              published_date: "2023-01-15" 
            } 
          }
        }.to change(Book, :count).by(1)
        
        expect(response).to redirect_to(books_path)
        follow_redirect!
        expect(flash[:notice]).to eq("Book was successfully created.")
        
        book = Book.last
        expect(book.title).to eq("Complete Book")
        expect(book.author).to eq("John Smith")
        expect(book.price).to eq(29.99)
        expect(book.published_date).to eq(Date.parse("2023-01-15"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book and renders the new template with error notice" do
        expect {
          post books_path, params: { book: { title: "" } }
        }.to_not change(Book, :count)
        
        expect(response).to have_http_status(:ok)  # Status 200 when render :new
        expect(response).to render_template(:new)
        expect(assigns(:book).errors[:title]).to include("can't be blank")
      end

      it "does not create a book without an author" do
        expect {
          post books_path, params: { 
            book: { 
              title: "No Author Book",
              author: "",
              price: 19.99,
              published_date: "2023-01-15" 
            } 
          }
        }.to_not change(Book, :count)
        
        expect(response).to render_template(:new)
        expect(assigns(:book).errors[:author]).to include("can't be blank")
      end

      it "does not create a book with a negative price" do
        expect {
          post books_path, params: { 
            book: { 
              title: "Negative Price Book",
              author: "Jane Doe",
              price: -5.99,
              published_date: "2023-01-15" 
            } 
          }
        }.to_not change(Book, :count)
        
        expect(response).to render_template(:new)
        expect(assigns(:book).errors[:price]).to include("must be greater than or equal to 0")
      end

      it "does not create a book without a published date" do
        expect {
          post books_path, params: { 
            book: { 
              title: "No Date Book",
              author: "Jane Doe",
              price: 15.99,
              published_date: "" 
            } 
          }
        }.to_not change(Book, :count)
        
        expect(response).to render_template(:new)
        expect(assigns(:book).errors[:published_date]).to include("can't be blank")
      end
    end
  end
end
