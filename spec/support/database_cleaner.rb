RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |spec|
    if spec.metadata[:js] || spec.metadata[:test_commit]
      spec.run
      DatabaseCleaner.clean_with :deletion
    else
      DatabaseCleaner.start
      spec.run
      DatabaseCleaner.clean
      begin
        ActiveRecord::Base.connection.send(:rollback_transaction_records, true)
      rescue
      end
    end
  end

end