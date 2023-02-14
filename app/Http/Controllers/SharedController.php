<?php

namespace App\Http\Controllers;

use App\Packages\XLSXWriter;
use Illuminate\Http\Request;
use App\Models\Stock\Requisition;
use App\Http\Controllers\Controller;

class SharedController extends Controller
{
     /**
     * Handle Exporting
     * @param \Illuminate\Http\Request
     */
    public function handleXLSXExport(Request $request) : void
    {
        $data     = json_decode($request->input('dataset'));
        $filename = $request->input('filename') . "_" . date('Y-m-d') . '-' . date('H:i') . ".xlsx";
        $columns = json_decode($request->input('columns'));
        $headings = [];
        foreach($columns as $column) {
            $headings[$column] = 'string';
        }
        header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', TRUE, 200);
        header('Content-Transfer-Encoding: binary');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        $writer = new XLSXWriter();
        $writer->setAuthor('Clinic Plus');
        $writer->writeSheetHeader('Sheet1', $headings );
        foreach($data as $row) {
            $writer->writeSheetRow('Sheet1', (array)$row );
        }
        $writer->writeToStdOut();
        exit(0);
    }

    /**
     * 
     * Get notifications badge
     * @return JsonResponse
     */
    public function getNotificationBadge()
    {
        return response()->json([
            'status' => 1,
            'data' => [
                'requisitions' => Requisition::where('status', 'PENDING')->count(),
            ]
        ]);
    }
}