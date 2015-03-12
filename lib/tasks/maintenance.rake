namespace :maintenance do
  desc 'Maintenance tasks for sacobs'
  task bookings_cleanup: :environment do
    puts 'Beginning bookings clean up'
    puts "#{Booking.in_process.size} to be removed"
    Booking.in_process.destroy_all
    puts 'Bookings clean up complete'
  end

  task archive_trips: :environment do
    trips = Trip.where.not(id: Trip.valid)
    trips.find_each do |trip|
        Trip.transaction do
          trip.bookings.each(&:archive!)
          trip.archive!
        end
    end
  end
end
