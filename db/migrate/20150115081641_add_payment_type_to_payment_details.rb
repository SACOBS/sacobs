class AddPaymentTypeToPaymentDetails < ActiveRecord::Migration
  class PaymentType < ActiveRecord::Base
  end

  def change
    add_column :payment_details, :payment_type, :string

    PaymentDetail.all.each { |pd| pd.update!(payment_type: PaymentType.find(pd.payment_type_id).description)}
  end
end
