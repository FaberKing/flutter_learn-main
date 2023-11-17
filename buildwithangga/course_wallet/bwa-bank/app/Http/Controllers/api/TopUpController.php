<?php

namespace App\Http\Controllers\api;

// use App\Http\Controllers\Controller;
// use Illuminate\Http\Request;
// use App\Models\Transaction;
// use App\Models\TransactionType;
// use App\Models\PaymentMethod;
// use Illuminate\Support\Facades\Validator;
// use Illuminate\Support\Str;
// use Illuminate\Support\Facades\DB;
// // use Midtrans\Snap;

// class TopUpController extends Controller
// {
//    public function store(Request $request){
//         $data = $request->only('amount', 'pin', 'payment_method_code');

//         $validator = Validator::make($data, [
//             'amount' => 'required|integer|min:10000',
//             'pin' => 'required|digits:6',
//             'payment_method_code' => 'required|in:bni_va,bca_va,bri_va',
//         ]);

//         if ($validator->fails()) {
//             return response()->json([
//                 'errors' => $validator->messages(),
//             ], 400);
//         }

//         $pinChecker = pinChecker($request->pin);

//         if (!$pinChecker) {
//             return response()->json([
//                 'message' => 'Your PIN is wrong',
//             ], 400);
//         }

//         $transactionType = TransactionType::where('code', 'top_up')->first();
//         $paymentMethod = PaymentMethod::where('code', $request->payment_method_code)->first();

//         DB::beginTransaction();

//         try {
//             $transaction = Transaction::create([
//                 'user_id' => auth()->user()->id,
//                 'payment_method_id' => $paymentMethod->id,
//                 'transaction_type_id' => $transactionType->id,
//                 'amount' => $request->amount,
//                 'transaction_code' => strtoupper(Str::random(10)),
//                 'description' => 'Top Up via '.$paymentMethod->name,
//                 'status' => 'pending',
//             ]);

//             $params = $this->buildMidtransParameter([
//                 'transaction_code' => $transaction->transaction_code,
//                 'amount' => $transaction->amount,
//                 'payment_method' => $paymentMethod->code,
//             ]);

//             $midtrans = $this->callMidtrans($params);

//             DB::commit();

//             return response()->json($midtrans);
            
//         } catch (\Throwable $th) {
//             DB::rollBack();

//             return response()->json(['message' => $th->getMessage()], 500);
//         }
//    }

//    private function callMidtrans(array $params){

//         \Midtrans\Config::$serverKey = env('MIDTRANS_SERVER_KEY');
//         \Midtrans\Config::$isProduction = (bool) env('MIDTRANS_IS_PRODUCTION');
//         \Midtrans\Config::$isSanitized = (bool) env('MIDTRANS_IS_SANITIZED');
//         \Midtrans\Config::$is3ds = (bool) env('MIDTRANS_IS_3DS');

//         $createTransaction = \Midtrans\Snap::createTransaction($params);

//         return [
//             'redirect_url' => $createTransaction->redirect_url,
//             'token' => $createTransaction->token,
//         ];
//         // return $createTransaction;
//    }

//    private function buildMidtransParameter(array $params){
//         $transactionDetails = [
//             'order_id' => $params['transaction_code'],
//             'gross_amount' => $params['amount'],
//         ];

//         $user = auth()->user();
//         $splitName = $this->splitName($user->name);
//         $customerDetails = [
//             'first_name' => $splitName['first_name'],
//             'last_name' => $splitName['last_name'],
//             'email' => $user->email,
//             // 'phone' => '0832323232'
//         ];

//         $enablePayment = [
//             $params['payment_method'],
//         ];

//         return [
//             'transaction_details' => $transactionDetails,
//             'customer_details' => $customerDetails,
//             'enabled_payments' => $enablePayment,
//         ];
//    }

//    private function splitName($fullName){
//     $name = explode(' ', $fullName);

//     $lastName = count($name) > 1 ? array_pop($name) : $fullName;
//     $firstName = implode(' ', $name);

//     return [
//         'first_name' => $firstName,
//         'last_name' => $lastName,
//     ];
//    }
// }

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Transaction;
use App\Models\TransactionType;
use App\Models\PaymentMethod;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Midtrans\Config;
use Midtrans\Snap;

class TopUpController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->only('amount', 'pin', 'payment_method_code');
        
        $validator = Validator::make($data, [
           'amount' => 'required|integer|min:10000',
           'pin' => 'required|digits:6',
           'payment_method_code' => 'required'
        ]);
        
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        $pinChecker = pinChecker($request->pin);
        if (!$pinChecker) {
            return response()->json(['message' => 'Your PIN is wrong'], 400);
        }

        $transactionType = TransactionType::where('code', 'top_up')->first();
        $paymentMethod = PaymentMethod::where('code', $request->payment_method_code)->first();

        DB::beginTransaction();

        try {
            $transaction = Transaction::create([
                'user_id' => auth()->user()->id,
                'payment_method_id' => $paymentMethod->id,
                'transaction_type_id' => $transactionType->id,
                'amount' => $request->amount,
                'transaction_code' => strtoupper(Str::random(10)),
                'description' => 'Top Up via '.$paymentMethod->name,
                'status' => 'Pending',
            ]);

            $params = $this->buildMidtransParameter([
                'transaction_code' => $transaction->transaction_code,
                'amount' => $transaction->amount,
                'payment_method' => $paymentMethod->code
            ]);

            $midtrans = $this->callMidtrans($params);
            
            DB::commit();

            return response()->json($midtrans);
        } catch (\Throwable $th) {
            DB::rollback();

            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    private function callMidtrans(array $params)
    {
        Config::$serverKey = 'SB-Mid-server-42hXxM7hauZdX8lWUnQt3m-E';
        Config::$clientKey = 'SB-Mid-client-1mVTFc2uPYow9C2F';
        Config::$isProduction = false;
        Config::$isSanitized = true;
        Config::$is3ds = true;
        
        $param1 = array(
                 'transaction_details' => array(
                   'order_id' => rand(),
                   'gross_amount' => 10000,
                 )
              );
       
        $createTransaction = Snap::createTransaction($params);
         
            return [
                'redirect_url' => $createTransaction,
                'token' => $createTransaction->token
            ];

    }

    private function buildMidtransParameter(array $params)
    {
        $transactionDetails = [
            'order_id' => $params['transaction_code'],
            'gross_amount' => $params['amount']
        ];

        $user = auth()->user();
        $splitName = $this->splitName($user->name);
        $customerDetails = [
            'first_name' => $splitName['first_name'],
            'last_name' => $splitName['last_name'],
            'email' => $user->email
        ];

        $enabledPayments = [
            $params['payment_method']
        ];

        return [
            'transaction_details' => $transactionDetails,
            'customer_details' => $customerDetails,
            // 'enabled_payments' => $enabledPayments
        ];
    }

    private function splitName($fullName)
    {
        $name = explode(' ', $fullName);
        
        $lastName = count($name)  > 1 ? array_pop($name) : $fullName;
        $firstName = implode(' ', $name);

        return [
            'first_name' => $firstName,
            'last_name' => $lastName
        ];
    }
}