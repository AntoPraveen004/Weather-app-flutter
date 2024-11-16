from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, firestore
import threading

app = Flask(_name_)

# Initialize Firebase
cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred, {"databaseURL": "https://sibh-1bbf2-default-rtdb.asia-southeast1.firebasedatabase.app/"})
ref = db.reference("/")

# Define the function that performs the booking
def app_bk():
    lis = []
    a = db.reference("/doctorA/").get()
    b = db.reference("/doctorB/").get()
    for i in a.keys():
        lis.append(i)

    for i in lis:
        if a[i] == 0:
            db.reference("/doctorA/").update({i: 1})
            print("Appointment booked on A at ", i)
            break
        elif b[i] == 0:
            db.reference("/doctorB/").update({i: 1})
            print("Appointment booked on B at ", i)
            break
        elif i == '1030' and b[i] == 1:
            print("No more appointments")
            break

def book_app(time, doc):
    print("time : ",time)
    print("doc : ",doc)
    if doc == 'A':
        a = f"/doctorA/{time}"
        if db.reference(a).get() == 0:
            db.reference("/doctorA/").update({time: 1})
            print("Appointment booked for doctor A at", time)
        else:
            print(f"Appointment for doctor A at {time} is not available")

    elif doc == 'B':
        a = f"/doctorB/{time}"
        if db.reference(a).get() == 0:
            db.reference("/doctorB/").update({time: 1})
            print("Appointment booked for doctor B at", time)
        else:
            +print(f"Appointment for doctor B at {time} is not available")

def del_appointment(time, doctor):
    if doctor == 'A':
        a = f"/doctorA/{time}"
        if db.reference(a).get() == 1:
            db.reference("/doctorA/").update({time: 0})
            print("Appointment cancelled for doctor A at", time)
        else:
            print(f"Appointment for doctor A at {time} is not booked")

    elif doctor == 'B':
        a = f"/doctorB/{time}"
        if db.reference(a).get() == 1:
            db.reference("/doctorB/").update({time: 0})
            print("Appointment cancelled for doctor B at", time)
        else:
            print(f"Appointment for doctor B at {time} is not booked")


# Define the route to trigger the Python function
@app.route('/trigger_python_function', methods=['GET'])
def trigger_python_function():
    threading.Thread(target=app_bk).start()
    return "Python function triggered successfully"

# Define the route to book an appointment
@app.route('/book_appointment', methods=['POST'])
def book_appointment():
        data = request.form
        time = data.get('code')
        doctor = data.get('doctor')
        if time and doctor:
            print(f'Appointment booked for code {time} with doctor {doctor}')
            book_app(time, doctor)
            return "Appointment booked successfully"
        else:
            book_app(time, doctor)
            return "Failed to book appointment"

@app.route('/delete_appointment', methods=['POST'])
def delete_appointment():
    data = request.form
    time = data.get('code')
    doctor = data.get('doctor')

    if time and doctor:
        print(f'Attempting to delete appointment for code {time} with doctor {doctor}')
        del_appointment(time, doctor)
        return "Appointment deleted successfully"
    else:
        print('Invalid data. Please provide code and doctor.')
        return "Failed to delete appointment"

if _name_ == '_main_':
    app.run(host='0.0.0.0', port=5000)