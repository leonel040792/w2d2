require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name=name
        @funding= funding
        @salaries=salaries
        @employees=[]
    end

    def valid_title?(title)
        @salaries.key?(title)
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(employee, title)
        if valid_title?(title)
            @employees << Employee.new(employee, title)
        else
            raise "the title is invalid"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "there's not enough funding"
        end
    end

    def payday
        @employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
         @employees.map{ |worker| @salaries[worker.title]}.sum/@employees.length
    end

    def close
        @employees=[]
        @funding=0
    end

    def acquire(another_startup)
        @funding += another_startup.funding
        another_startup.salaries.each {|title, salary| @salaries[title]=salary unless @salaries.has_key?(title)}
        @employees+= another_startup.employees
        another_startup.close
    end

    
end
