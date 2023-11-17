<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Models\Wallet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class WebhookController extends Controller
{
    public function update(){
        \Midtrans\Config::$serverKey = env('MIDTRANS_SERVER_KEY');
        \Midtrans\Config::$isProduction = (bool) env('MIDTRANS_IS_PRODUCTION', false);
        $notif = new \Midtrans\Notification();

        $transactionStatus = $notif->transaction_status;
        $type = $notif->payment_type;
        $trasactionCode = $notif->order_id;
        $fraud = $notif->fraud_status;

        DB::beginTransaction();

        try {
            $status = null;

            // if ($transactionStatus == 'capture'){
            //     if ($fraud == 'accept'){
            //             // TODO set transaction status on your database to 'success'
            //             // and response with 200 OK
            //             $status = 'success';
            //         }
            //     } else if ($transactionStatus == 'settlement'){
            //         // TODO set transaction status on your database to 'success'
            //         // and response with 200 OK
            //         $status = 'success';
            //     } else if ($transactionStatus == 'cancel' ||
            //       $transactionStatus == 'deny' ||
            //       $transactionStatus == 'expire'){
            //       // TODO set transaction status on your database to 'failure'
            //       // and response with 200 OK
            //       $status = 'failure';
            //     } else if ($transactionStatus == 'pending'){
            //       // TODO set transaction status on your database to 'pending' / waiting payment
            //       // and response with 200 OK
            //       $status = 'pending';
            //     }

                if ($transactionStatus == 'capture') {
                    if ($type == 'credit_card'){
                      if($fraud == 'accept'){
                        // TODO set payment status in merchant's database to 'Success'
                        $status = 'success';
                        }
                      }
                    }
                  else if ($transactionStatus == 'settlement'){
                    // TODO set payment status in merchant's database to 'Settlement'
                    $status = 'settlement';
                    }
                    else if($transactionStatus == 'pending'){
                    // TODO set payment status in merchant's database to 'Pending'
                    $status = 'pending';
                    }
                    else if ($transactionStatus == 'deny') {
                    // TODO set payment status in merchant's database to 'Denied'
                    $status = 'denied';
                    }
                    else if ($transactionStatus == 'expire') {
                    // TODO set payment status in merchant's database to 'expire'
                    $status = 'expire';
                    }
                    else if ($transactionStatus == 'cancel') {
                    // TODO set payment status in merchant's database to 'Denied'
                    $status = 'denied';
                  }

                $transaction = Transaction::where('transaction_code', $trasactionCode)->first();

                if ($transaction->status != 'success') {
                    $transactionAmount = $transaction->amount;
                    $userId = $transaction->user_id;

                    $transaction->update(['status' => $status]);

                    if ($status == 'success') {
                        Wallet::where('user_id', $userId)->increment('balance', $transactionAmount);
                    }
                }
            
            DB::commit();
            return response()->json();
        } catch (\Throwable $th) {
            DB::rollBack();
            return response()->json([
                'message' => $th->getMessage()
            ]);
        }
    }
}
