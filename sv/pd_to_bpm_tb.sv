module pd_to_bpm_tb;

    logic [7:0] pd, bpm;

    pd_to_bpm DUV (.pd, .bpm);

    initial begin
        for (int i=0; i<=255; i++) begin
            pd = i;
            #5;
            $display("pd=%d, bpm=%d", pd, bpm);
        end
    end

endmodule
