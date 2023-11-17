<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TipSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('tips')->insert([
            [
                'title' => 'Cara menyimpan uang yang baik',
                'thumbnail' => 'nabung.jpg',
                'url' => 'https://www.kompas.com/',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Cara Jalan',
                'thumbnail' => 'emas.jpg',
                'url' => 'https://www.kompas.com/',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Cara minum',
                'thumbnail' => 'saham.jpg',
                'url' => 'https://www.kompas.com/',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Cara makan',
                'thumbnail' => 'nabung.jpg',
                'url' => 'https://www.kompas.com/',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
