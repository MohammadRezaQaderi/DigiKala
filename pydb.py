import pyodbc
from os import system ,name
from time import sleep
from datetime import date

def clear():
  
    # for windows
    if name == 'nt':
        _ = system('cls')
  
    # for mac and linux(here, os.name is 'posix')
    else:
        _ = system('clear')

def menu():
    print("""
            1)Buy
            2)See Goods
            3)Add Comment
            4)Show my Bill
            5)Show Score
            6)Use Score
            7)See budget
            8)See Commets of This Goods
            9)My Info
            10)exit
    """)

server = 'MOHAMMAD' 
database = 'FinalProject' 
username = 'MOHAMMAD' 
password = 'm2711gH9985' 
conx = pyodbc.connect("driver={ODBC Driver 17 for SQL Server}; server=MOHAMMAD; database=FinalProject; trusted_connection=YES;")
print("Connection Successfully Established")  
cursor = conx.cursor()
# exec_str =  "select Users.Users_score from Users"
# cursor.execute(exec_str)
# for row in cursor:
#     print(row)
print("Hello Welcome To My digikala ^_^")
while True:
    menu()
    key = int(input())
    exec_str = ""
    # finish
    if key == 1:
        # buy some goods
        print("")
        print("please enter Your ID : ")
        user_id = int(input())
        print("please enter Goods ID : ")
        good_id = int(input())
        can = 0
        # exec_str =  "exec enoughMoney @user_id = ? , @good_id = ? ,@can = can output",user_id ,good_id
        cursor.execute("declare @out int; exec enoughMoney @user_id = ? , @good_id = ? ,@can = @out OUTPUT; select @out AS the_output;",user_id ,good_id )
        for x in cursor:
            print(x.the_output)
            can = x.the_output
        if(can == 0):
            print("You don't have enough Money to buy this goods")
        elif(can == 2):
            print("You can buy this goods by use Your score at first click 6 after that you can buy ")
        else:
            date_now = date.today()
            cursor.execute("""
                            insert into history
                            (Users_id , Goods_id, Date_of_buy ) values (?, ?, ?)
                            """, (user_id , good_id,date_now))
            conx.commit()
            print("Thanks For you Buy :)")
            exec_str =  "select * from history"
            cursor.execute(exec_str)
            for row in cursor:
                print(row)
            print(":)")        

    # finish
    elif key == 2:
        # see the goods
        print("goods")
        exec_str =  "select * from Goods where Goods.stock > 0"
        cursor.execute(exec_str)
        
        for row in cursor:
            print(row)
    
    # finish
    elif key == 3:
        # add comment
        cursor.execute("select top 1 Com_id from Comments")
        for row in cursor:
            print(row)
            Com_id = row.Com_id
        print("add comment")
        print("please enter Your ID : ")
        user_id = int(input())
        print("please enter Goods ID : ")
        goods_id = int(input())
        print("please Your Comment : ")
        comment = str(input())
        date_now = date.today()
        print(date_now)
        computed = 'Y'
        cursor.execute("""
                        insert into Comments
                        (Users_id ,Goods_id, Com_body ,Date_of_Com )
                        values (?, ?, ?, ?)
                        """
                        ,(user_id, goods_id,comment,date_now))
        conx.commit()

        exec_str =  "select * from Comments"
        cursor.execute(exec_str)
        
        for row in cursor:
            print(row)
    # finish
    elif key == 4:
        # show my bill
        print("please enter Your ID : ")
        id = int(input())
        # exec_str =  "select * from bill(?)",id
        cursor.execute("select * from bill(?)",id)
    
        for row in cursor:
            print("The Bill of You is : " + str(row))
    
    # finish
    elif key == 5:
        # show my score
        print("show score")
        print("please enter Your ID : ")
        id = int(input())
        # exec_str =  "select Users.Users_score from Users where Users.Users_id = ?",id
        cursor.execute("select Users.Users_score from Users where Users.Users_id = ?",id)
        
        for row in cursor.fetchall():
            print("Your Score is : " +str(row.Users_score))
    
    # finish
    elif key == 6:
        # use the score
        print("use score to make money :) ")
        print("please enter Your ID : ")
        id = int(input())
        sql = """\
            declare @out int;
            exec MakeMoney @user_id = ? ,@cash = @out OUTPUT;
            select @out AS the_output;
            """ 
        params = (id, )
        cursor.execute(sql, params)
        conx.commit()
        cursor.execute("select Users.Users_cash from Users where Users.Users_id = ?" , id)
        for row in cursor:
            print("Your Budget Update to $: " + str(row.Users_cash)) 
    # finish
    elif key == 7:
        # see my budget
        print("budget")
        print("please enter Your ID : ")
        id = int(input())
        # exec_str =  "select Users.Users_cash from Users where Users.Users_id = ?",id
        cursor.execute("select Users.Users_cash from Users where Users.Users_id = ?",id)
        for row in cursor:
            print("Your Budget is $: " + str(row.Users_cash))

    elif key == 8:
        # the Goods comment
        print("please enter Goods ID : ")
        id = int(input())
        cursor.execute("select * from Comments_of_Goods(?)",id)
        for row in cursor:
            print(str(row.Com_body) + " in  " + str(row.Date_of_Com))
    
    # finish
    elif key == 9:
        print("please enter Your ID : ")
        id = int(input())
        cursor.execute("select * from Users where Users.Users_id = ? ", id)
        for row in cursor:
            print("Your Information is : ")
            print(row)
    
    elif key == 10:
        print("Thanks For your Visiting , Come Back Soon O_O")
        print("\U0001F917")
        break
    
    else:
        print("Wrong Input , Please Choese From Menu")

    sleep(5)
    clear()


# cursor.execute('SELECT* FROM dbo.Users')
# for row in cursor:
#     print(row)