class AddPaymentTypeToPaymentDetails < ActiveRecord::Migration
  class PaymentType < ActiveRecord::Base
  end

  def change
    add_column :payment_details, :payment_type, :string

    PaymentDetail.find_each do  |pd|
      pd.payment_type = PaymentType.find(pd.payment_type_id).description
      pd.save(validate: false)
    end
  end
end
