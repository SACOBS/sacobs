class PassengerPresenter

  delegate :name, :surname, :email, :cell_no, :passenger_type_description, to: :passenger

  attr_reader :passenger
  def initialize(passenger, view_context)
    @passenger = passenger
    @view_context = view_context
  end

  def passenger_type
    passenger_type_description.capitalize
  end

  def cellphone
      return 'N/A' unless passenger.cell_no?
      @view_context.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless passenger.email?
    @view_context.mail_to(email)
  end
end