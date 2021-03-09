const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
export const firestore = admin.firestore();

const sendPushNotification = function(token:string,title:string,body:string,badge:string) {

    const payload = {
        notification: {
            title: title,
            body: body,
            badge: badge,
            sound:"default"
        }
    };
    const option = {
        priority: "high"
    };

    admin.messaging().sendToDevice(token,payload,option);
}

// 新規依頼作時
export const createRequest = functions.firestore.document('/request/{request}')
    .onCreate( async (snapshot, context) => {
        const request = snapshot.data()
        const requestStatus = request['status']
        if (requestStatus === "未対応") {
            const senderUid = request["adviserId"]
            const adviserRef = firestore.collection("adviser").doc(senderUid)
            adviserRef.get().then(function(doc){
                if (doc.exists === true) {
                    const adviser = doc.data()
                    const fcmToken = adviser["fcmToken"]
                    const studentName = request["studentName"]
                    const requestType = request["type"]
                    const title = '新規依頼'
                    const body = `${studentName}から新規の依頼(${requestType})がきました`
                    sendPushNotification(fcmToken,title,body,"1");
                    console.log("newRequest")
                 } else {
                    console.log("notExists")
                }
            })
        } else {
            console.log("statusNotFound")
        }
})

// 依頼更新時
export const updateRequest = functions.firestore.document('/request/{request}')
    .onUpdate( async (change, context) => {
        const request = change.after.data()
        const requestStatus = request['status']
        if (requestStatus === "対応中") {
            const senderUid = request["studentId"]
            const adviserRef = firestore.collection("student").doc(senderUid)
            adviserRef.get().then(function(doc){
                if (doc.exists === true) {
                    const student = doc.data()
                    const fcmToken = student["fcmToken"]
                    const adviserName = request["adviserName"]
                    const requestType = request["type"]
                    const title = '依頼対応中'
                    const body = `${adviserName}がの依頼(${requestType})の期限を返答しました`
                    sendPushNotification(fcmToken,title,body,"1");
                    console.log("updateRequest")
                } else {
                    console.log("notExists")
                }
            })
        } else if (requestStatus === "対応済み") {
            const senderUid = request["studentId"]
            const adviserRef = firestore.collection("student").doc(senderUid)
            adviserRef.get().then(function(doc){
                if (doc.exists === true) {
                    const student = doc.data()
                    const fcmToken = student["fcmToken"]
                    const adviserName = request["adviserName"]
                    const requestType = request["type"]
                    const title = '依頼完了'
                    const body = `${adviserName}がの依頼(${requestType})の対応が完了しました`
                    sendPushNotification(fcmToken,title,body,"1");
                    console.log("updateRequest")
                } else {
                    console.log("notExists")
                }
            })
        } else {
            console.log("statusNotFound")
        }
    })
