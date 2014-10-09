class BookingForm < Reform::Form
  property :client do
    property :name
    property :surname
    property :home_no
    property :cell_no
    property :email
    property :high_risk
    property :bank_id
    property :work_no
    property :date_of_birth
    property :title
    property :notes
    property :id_number
  end
end
