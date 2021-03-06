require 'spec_helper'
feature "Deleting projects" do
  let(:user) { Factory(:confirmed_user) }
  let(:admin) { Factory(:admin_user) }

  before do
    sign_in_as!(Factory(:admin_user))
  end

  context "admin users" do
    scenario "Deleting a project" do
      Factory(:project, :name => "TextMate 2")
      visit "/"
      click_link "TextMate 2"
      click_link "Delete Project"
      page.should have_content("Project has been deleted.")
      visit "/"
      page.should_not have_content("TextMate 2")
    end
  end
end