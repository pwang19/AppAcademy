require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.each_key { |key| return true if title == key }
        return false
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(name, title)
        valid_title?(title) ? @employees << Employee.new(name, title) : (raise 'error: please enter a valid title.')
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise 'error: insufficient funds'
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee)}
    end

    def average_salary
        @employees.inject(0) { |sum, employee| sum + @salaries[employee.title] } / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each { |title, salary| @salaries[title] = salary if !@salaries.has_key?(title)}
        @employees += startup.employees
        startup.close
    end
end
