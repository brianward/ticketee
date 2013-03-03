require 'spec_helper'

feature 'Deleting tickets' do
  let!(:project) { Factory(:project) }
  let!(:user) { Factory(:confirmed_user) }
  let!(:ticket) do
    ticket = Factory(:ticket, :project => project)
    ticket.update_attribute(:user, user)
    ticket
  end

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "delete tickets", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario "Deleting a ticket" do
    click_link "Delete Ticket"
    page.should have_content("Ticket has been deleted.")
    page.current_url.should == project_url(project)
  end

  scenario "Creating a ticket with an attachment" do
    fill_in "Title", :with => "Add documentation for blink tag"
    fill_in "Description", :with => "The blink tag has a speed attribute"
    attach_file "File #1", "spec/fixtures/speed.txt"
    attach_file "File #2", "spec/fixtures/spin.txt"
    attach_file "File #3", "spec/fixtures/gradient.txt"
    click_button "Create Ticket"
    page.should have_content("Ticket has been created.")
    within("#ticket .assets") do
      page.should have_content("speed.txt")
      page.should have_content("spin.txt")
      page.should have_content("gradient.txt")
    end 
  end
end
