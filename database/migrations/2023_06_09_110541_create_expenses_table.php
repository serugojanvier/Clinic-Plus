<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExpensesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('expenses', function (Blueprint $table) {
            $table->id()->unsigned();
            $table->bigInteger('company_id');
            $table->bigInteger('category_id');
            $table->text('description',)->nullable();
            $table->bigInteger('amount');
            $table->bigInteger('payment_method');
            $table->bigInteger('created_by');
            $table->date('committed_date');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('expenses');
    }
}
