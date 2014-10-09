class BookingForm
  include ActiveModel::Model

  attr_reader :booking

  attr_accessor :client, :user


  def initialize(booking, attributes={})
    @booking = booking
    @client = booking.client
    super(attributes)
  end

  def client
    @client ||= booking.build_client
  end

  def client_attributes=(attributes)

    if attributes['id'].present?
      @client = Client.find(attributes['id'])
    else
      @client = booking.build_client
    end
    @client.assign_attributes(attributes)
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private
   def persist!
     puts client.inspect
     client.save!
     @booking.client = client
     @booking.save!
   end
end