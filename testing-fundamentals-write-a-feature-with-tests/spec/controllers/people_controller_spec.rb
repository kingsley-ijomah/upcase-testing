require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person = Person.create(first_name: "Bob")
        allow(person).to receive(:save).and_return(true)
        allow(Person).to receive(:new).
          with(first_name: "Bob").
          and_return(person)

        post :create, person: { first_name: "Bob" }

        expect(response).to redirect_to(person_path(person))
      end
    end

    context "when person is invalid" do
      it "redirects to #new" do
        person = double("person")
        allow(person).to receive(:save).and_return(false)
        allow(Person).to receive(:new).with(first_name: "").and_return(person)

        post :create, person: { first_name: "" }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "has instance variable set" do 
      person = Person.create(first_name: "Bob")
      get :edit, id: person

      expect(assigns(:person)).to be_an_instance_of Person
    end
  end

  describe "PATCH #update" do
    it "redirects to person url" do
      person = Person.create(first_name: "Bob")
      patch :update, id: person.id, person: {first_name: 'Kingsley'}

      expect(response).to redirect_to(person_url)
    end
  end
end
