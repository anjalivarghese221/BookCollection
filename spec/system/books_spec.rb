require 'rails_helper'

RSpec.describe "Books", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Creating a book" do
    it "creates a book with all valid attributes" do
      visit new_book_path
      
      fill_in "Title", with: "My New Book"
      fill_in "Author", with: "Test Author"
      fill_in "Price", with: 15.99
      
      # Select a date from the dropdowns
      select Date.today.year.to_s, from: "book_published_date_1i"
      select Date::MONTHNAMES[Date.today.month], from: "book_published_date_2i"
      select Date.today.day.to_s, from: "book_published_date_3i"
      
      click_button "Create Book"
      
      expect(page).to have_content("Book was successfully created.")
      expect(page).to have_content("My New Book")
    end

    it "displays an error when trying to create a book without a title" do
      visit new_book_path
      
      fill_in "Title", with: ""
      click_button "Create Book"
      
      expect(page).to have_content("Title can't be blank")
      expect(current_path).to eq(books_path) # This may vary based on your form setup
    end
    
    it "creates a book with all attributes filled in" do
      visit new_book_path
      
      fill_in "Title", with: "Complete Book"
      fill_in "Author", with: "John Smith"
      fill_in "Price", with: 29.99
      # Assuming there's a date picker or date field
      fill_in "Published date", with: "2023-01-15"
      
      click_button "Create Book"
      
      expect(page).to have_content("Book was successfully created.")
      expect(page).to have_content("Complete Book")
      expect(page).to have_content("John Smith")
      expect(page).to have_content("$29.99")
      expect(page).to have_content("2023-01-15")
    end
    
    it "displays errors when author is missing" do
      visit new_book_path
      
      fill_in "Title", with: "No Author Book"
      fill_in "Author", with: ""
      fill_in "Price", with: 19.99
      fill_in "Published date", with: "2023-01-15"
      
      click_button "Create Book"
      
      expect(page).to have_content("Author can't be blank")
    end
    
    it "displays errors when price is invalid" do
      visit new_book_path
      
      fill_in "Title", with: "Negative Price Book"
      fill_in "Author", with: "Jane Doe"
      fill_in "Price", with: -5.99
      fill_in "Published date", with: "2023-01-15"
      
      click_button "Create Book"
      
      expect(page).to have_content("Price must be greater than or equal to 0")
    end
    
    it "displays errors when published date is missing" do
      visit new_book_path
      
      fill_in "Title", with: "No Date Book"
      fill_in "Author", with: "Jane Doe"
      fill_in "Price", with: 15.99
      fill_in "Published date", with: ""
      
      click_button "Create Book"
      
      expect(page).to have_content("Published date can't be blank")
    end
  end
end
