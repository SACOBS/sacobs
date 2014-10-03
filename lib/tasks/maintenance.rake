namespace :maintenance do
  desc 'Clean up in process bookings never completed'
  task bookings_cleanup: :environment do
    puts 'Beginning bookings clean up'
    puts "#{Booking.in_process.size} to be removed"
    Booking.in_process.destroy_all
    puts 'Bookings clean up complete'
  end
end
