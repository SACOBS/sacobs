namespace :maintenance do
  desc 'Maintenance tasks for sacobs'
  task bookings_cleanup: :environment do
    puts 'Beginning bookings clean up'
    puts "#{Booking.in_process.size} to be removed"
    Booking.in_process.destroy_all
    puts 'Bookings clean up complete'
  end

  task archive_trips: :environment do
    trips = Trip.where('start_date < ?', Date.current)
    trips.find_each do |trip|
        Trip.transaction do
          if trip.valid? && trip.bookings.any?
            trip.bookings.each(&:archive!)
            trip.archive!
          else
            trip.destroy!
          end
        end
    end
  end
end
