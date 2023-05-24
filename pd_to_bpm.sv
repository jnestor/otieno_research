module pd_to_bpm(
    input logic [7:0] pd,
    output logic [7:0] bpm
);

    always_comb begin
        int i;
        for (i=0; i<=255; i++) begin
            if (i == pd) bpm =int'( 6000.0/(float'i) );
        end
    end


endmodule