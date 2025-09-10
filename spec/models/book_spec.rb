require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with all required attributes" do
    book = Book.new(
      title: "Test Book",
      author: "John Doe",
      price: 29.99,
      published_date: Date.today
    )
    expect(book).to be_valid
  end

  it "is invalid without a title" do
    book = Book.new(
      title: nil,
      author: "John Doe",
      price: 29.99,
      published_date: Date.today
    )
    expect(book).to_not be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end

  # Tests for author attribute
  it "is valid with an author" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: 29.99,
      published_date: Date.today
    )
    expect(book).to be_valid
  end

  it "is invalid without an author" do
    book = Book.new(
      title: "Test Book",
      author: nil,
      price: 29.99,
      published_date: Date.today
    )
    expect(book).to_not be_valid
    expect(book.errors[:author]).to include("can't be blank")
  end

  # Tests for price attribute
  it "is valid with a positive price" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: 19.99,
      published_date: Date.today
    )
    expect(book).to be_valid
  end

  it "is invalid with a negative price" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: -10,
      published_date: Date.today
    )
    expect(book).to_not be_valid
    expect(book.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "is invalid without a price" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: nil,
      published_date: Date.today
    )
    expect(book).to_not be_valid
    expect(book.errors[:price]).to include("can't be blank")
  end

  # Tests for published_date attribute
  it "is valid with a published date" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: 19.99,
      published_date: Date.today
    )
    expect(book).to be_valid
  end

  it "is invalid without a published date" do
    book = Book.new(
      title: "Test Book",
      author: "Jane Doe",
      price: 19.99,
      published_date: nil
    )
    expect(book).to_not be_valid
    expect(book.errors[:published_date]).to include("can't be blank")
  end
end
