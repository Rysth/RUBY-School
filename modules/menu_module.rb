module Menu
  def self.main(app)
    app.clear_screen
    loop do
      app.display_menu_options
      choice = app.get_user_choice(1..7)

      case choice
      when 1 then app.list_books
      when 2 then app.list_people
      when 3 then app.create_person
      when 4 then app.create_book
      when 5 then app.create_rental
      when 6 then app.list_rentals_by_person
      when 7
        app.quit
        break
      end
    end
  end
end