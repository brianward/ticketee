require 'spec_helper'
feature "Viewing tickets" do
  
  before do
    user = Factory(:confirmed_user)
    textmate_2 = Factory(:project, :name => "TextMate 2")
    define_permission!(user, "view", textmate_2)
    ticket = Factory(:ticket,
                 :project => textmate_2,
                 :title   => "Make it shiny!",
                 :description => "Gradients! Starbursts! Oh my!")
    ticket.update_attribute(:user, user)
    internet_explorer = Factory(:project, :name => "Internet Explorer")
    define_permission!(user, "view", internet_explorer)
    Factory(:ticket,
            :project => internet_explorer,
            :title => "Standards compliance",
            :description => "Isn't a joke.")
    sign_in_as!(user)
    visit '/' 
  end

  context "regular users" do
    scenario "Viewing tickets for a given project" do
      click_link "TextMate 2"
      page.should have_content("Make it shiny!")
      page.should_not have_content("Standards compliance")
      click_link "Make it shiny!"
      within("#ticket h2") do
        page.should have_content("Make it shiny!")
      end
      page.should have_content("Gradients! Starbursts! Oh my!")
    end

    scenario "Delete ticket link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "delete tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end

    scenario "Delete ticket link is hidden from users without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end
  end  
end