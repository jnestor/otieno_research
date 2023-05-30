module pd_to_bpm(
    input logic [7:0] pd,
    output logic [7:0] bpm
);


    // note every value with period < ?? will not fit in 8 bits!
    always_comb begin
        int i;
        bpm = 0;  // default val
        for (i=0; i<=255; i++) begin
            if (i == pd) begin
                if (i <= 23) bpm = 255;
                else bpm = int'( 6000.0/i );
            end
        end
    end


endmodule